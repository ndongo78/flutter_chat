import 'package:chatndong/controllers/auth_controller.dart';
import 'package:chatndong/screens/chat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/users.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    // TODO: implement initState
    authController.getUsers(authController.token.value);
    authController.initilizeSocket();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                //header
                Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: [
                          const Text(
                            'CHATNDONG',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Color(0xFFE5E5E5),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 4),
                            child: const Text(
                              'Bonjour John 👋',
                              style: TextStyle(
                                  color: Color(0xFFE5E5E5),
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.notifications,
                          color: Color(0xFFE5E5E5),
                          size: 30,
                        ),
                      )
                    ],
                  ),
                ),
                //users list
                Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8.0, right: 8.0, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text(
                            'Story',
                            style: TextStyle(
                                color: Color(0xFFE5E5E5), fontSize: 20),
                          ),
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              textStyle: const TextStyle(
                                color: Color(0xFFE5E5E5),
                              ),
                            ),
                            child: Text('voir plus'),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 40, left: 5),
                          child: ElevatedButton(
                            onPressed: () {}, // icon of the button
                            style: ElevatedButton.styleFrom(
                              // styling the button
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(30),
                              backgroundColor: Colors.blueGrey, // Button color
                            ),
                            child: const Icon(Icons.add, color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: SizedBox(
                            height: 150,
                            width: MediaQuery.of(context).size.width - 100,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: users.length,
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () => print('voir plus'),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(10),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.black,
                                        radius: 40,
                                        child: ClipOval(
                                          child: Image.network(
                                            users[index]['avatar'],
                                            fit: BoxFit.cover,
                                            width: 80,
                                            height: 120,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      users[index]['name'],
                                      style: const TextStyle(
                                          color: Color(0xFFE5E5E5),
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE5E5E5),
                    borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(40),
                      topEnd: Radius.circular(40),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Padding(
                          padding:
                              EdgeInsets.only(top: 12.0, left: 12, bottom: 20),
                          child: Text(
                            "Derniers messages",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        const Divider(
                          height: .1,
                          thickness: .2,
                          endIndent: 0,
                          color: Colors.grey,
                        ),

                        //list users chtas
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: Obx(
                            () => ListView.builder(
                                itemCount: authController.users.length,
                                itemBuilder: (context, index) {
                                  if (authController.currentUser['_id'] ==
                                      authController.users[index]['_id']) {
                                    return SizedBox
                                        .shrink(); // Skip adding this user
                                  }
                                  return GestureDetector(
                                    onTap: () {
                                      String senderId =
                                          authController.currentUser['_id'];
                                      String receiverId =
                                          authController.users[index]['_id'];
                                      final room = {
                                        'senderId': senderId,
                                        'receiverId': receiverId
                                      };
                                      final token = authController.token.value;
                                      final conversationId = authController
                                          .conversations.value['_id'];
                                      // authController.getConversations(id, token);
                                      // if(authController.conversations.value != null){
                                      //   authController.getMessages(conversationId, token);
                                      //   Navigator.of(context).push(
                                      //     MaterialPageRoute(
                                      //       builder: (context) => ChatScreen(
                                      //         user:authController.users[index],
                                      //           conversation: conversationId
                                      //       ), 6515c39581673ace832fc03a
                                      //     ),
                                      //   );
                                      // }else{}
                                      authController
                                          .createConversations(room, token)
                                          .then((value) => {
                                                authController.getMessages(
                                                    authController.conversations
                                                        .value['_id'],
                                                    token),
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ChatScreen(
                                                            user: authController
                                                                .users[index],
                                                            conversation:
                                                                conversationId),
                                                  ),
                                                )
                                              })
                                          .catchError((error) => {
                                                print(
                                                    "Error creating conversation $error")
                                              });
                                      // if (authController.conversations.value !=
                                      //     {}) {
                                      //   authController.getMessages(
                                      //       authController
                                      //           .conversations.value['_id'],
                                      //       token);
                                      //   Navigator.of(context).push(
                                      //     MaterialPageRoute(
                                      //       builder: (context) => ChatScreen(
                                      //           user:
                                      //               authController.users[index],
                                      //           conversation: conversationId),
                                      //     ),
                                      //   );
                                      // }
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                margin:
                                                    const EdgeInsets.all(10),
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.black,
                                                  radius: 40,
                                                  child: ClipOval(
                                                    child: Image.network(
                                                      "https://picsum.photos/200/300",
                                                      fit: BoxFit.cover,
                                                      width: 80,
                                                      height: 120,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    authController.users[index]
                                                        ['username'],
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 8.0),
                                                    child: Text.rich(
                                                      TextSpan(
                                                          text: 'Bonjour '),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const Divider(
                                            height: .1,
                                            thickness: .2,
                                            endIndent: 0,
                                            color: Colors.grey,
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )),
        // Bas de page
        Positioned(
          left: 20,
          right: 20,
          bottom: 5,
          child: Container(
            height: 80, // Hauteur du bas de page
            decoration: BoxDecoration(
                color: Color(0xFF040303),
                borderRadius: BorderRadius.circular(50)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RawMaterialButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.call,
                    size: 35,
                    color: Colors.white60,
                  ),
                ),
                RawMaterialButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.message_outlined,
                    size: 35,
                    color: Colors.white60,
                  ),
                ),
                RawMaterialButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.person,
                    size: 35,
                    color: Colors.white60,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
