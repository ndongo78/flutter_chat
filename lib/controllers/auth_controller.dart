import 'dart:convert';
import 'dart:core';

import 'package:chatndong/screens/Home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:jwt_decode_full/jwt_decode_full.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class AuthController extends GetxController {
  RxString token = "".obs;
  RxMap currentUser = {}.obs;
  RxBool isLogin = false.obs;
  RxBool autoscrollExecuted = false.obs;
  dynamic users = [].obs;
  dynamic usersOnlines = [].obs;
  dynamic conversations = {}.obs;
  dynamic messages = [].obs;

  final url = "https://chatndongapi.ndongodev.com/api";
  // final url= "http://192.168.99.63:8100/api";
  final client = http.Client();
// http://192.168.99.63:5000/https://www.realtime-server.ndongodev.com
  // IO.Socket socket = IO.io("http://localhost:5000");
  late IO.Socket socket;

  initilizeSocket() {
    socket = IO.io(
      'http://192.168.1.129:5000',
      IO.OptionBuilder().setTransports(['websocket']).setTimeout(15000).build(),
    );
    socket.onConnect((_) {
      print('Connection established');
    });
    socket.on(
        'connection',
        (data) => {
              print('Connection established $data'),
              currentUser['socketId'] = data,
              socket.emit("register-new-user", currentUser),
              socket.on('user-connected', (data) => {usersOnlines.value = data})
            });

    socket.on(
        'messages',
        (data) => {
              autoscrollExecuted.value = true,
              messages.add(data),
            });
    socket.onDisconnect((_) => print('Disconnected'));
    socket.onConnectError((err) => print('Connect error: $err'));
    socket.onError((err) => print('Error: $err'));
  }

  Future<void> loginUser(String email, String password) async {
    try {
      var response = await client.post(Uri.parse('$url/users/login'),
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        dynamic user = jwtDecode(responseBody["token"]);
        token.value = responseBody["token"];
        currentUser.value = user.payload['user'];
        isLogin.value = true;
        Get.off(const HomeScreen());
        // La requête a réussi, l'utilisateur est connecté
        // print('Utilisateur connecté avec succès');
      } else {
        var responseBody = jsonDecode(response.body);
        // La requête a échoué, gérer les différents codes d'erreur ici
        print('Échec de la connexion ');
      }
    } catch (e) {
      // Une erreur s'est produite lors de la connexion
      print('Erreur lors de la connexion : $e');
    }
  }

  Future<void> getUsers(String token) async {
    var response = await client.get(Uri.parse('$url/users'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    // print('users ${response.body}');
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      List<dynamic> jsonDataList = responseBody as List<dynamic>;
      users.value = jsonDataList;
      // print('jsonDataList ${jsonDataList}');/**/
    } else {
      print('Erreur ${response}');
    }
  }

  Future<void> getConversations(String id, String token) async {
    var response =
        await client.get(Uri.parse('$url/conversations/$id'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.body == null) {
      return print("No response body was provided");
    }
  }

  Future createConversations(dynamic room, String token) async {
    var response = await client.post(Uri.parse('$url/conversations'),
        body: jsonEncode(room),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        });
    // print('createConversations ${response.body}');
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      conversations.value = responseBody;
      return responseBody;
    }
  }

  Future<void> getMessages(String id, String token) async {
    try {
      var response = await client.get(Uri.parse('$url/messages/$id'), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      // print('messages ${response.body}');
      if (response.statusCode == 200) {
        // print('getMessages ${response.body}');
        var responseBody = jsonDecode(response.body);
        messages.value = responseBody;
      }
    } catch (e) {
      print("error: $e");
    }
  }

  Future<void> createMessages(dynamic data, String token) async {
    messages.add(data);
    socket.emit("sendMessage", data);

    try {
      var response = await client.post(
        Uri.parse('$url/messages'),
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      messages.append(data);

      if (response.statusCode == 200) {
        // print('messages   ${response.body}');
        var responseBody = jsonDecode(response.body);
        messages.value.add(responseBody);
      }
    } catch (e) {
      print("error: $e");
    }
  }
}
