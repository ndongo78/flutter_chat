import 'package:chatndong/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:get/get.dart';
class ChatScreen extends StatefulWidget {
  Map user = {};
  dynamic conversation= {};

  ChatScreen({Key? key, required this.user,required this.conversation}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  AuthController authController = Get.put(AuthController());
  bool isText= false;
  ScrollController _scrollController = ScrollController();
  final formKey = GlobalKey<FormState>();
  String content="";

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) { });
      // Appeler la méthode getMessages après le rendu initial du widget
      String id = authController.conversations.value?['_id'] ?? '';
      String token = authController.token.value ?? '';
      authController.getMessages(id, token);
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Faites défiler vers le bas lorsque l'application est en cours d'exécution
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    print("message ${authController.messages}");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.user['username'],
          style: TextStyle(fontSize: 20),
        ),
        leading: CircleAvatar(
          backgroundColor: Colors.black,
          radius: 40,
          child: ClipOval(
            child: Image.network(
              "https://picsum.photos/200/300",
              fit: BoxFit.cover,
              width: 100,
              height: 150,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Ionicons.videocam_outline),
            color: Colors.white,
            iconSize: 35,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Ionicons.call_outline),
            color: Colors.white,
            iconSize: 30,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Ionicons.ellipsis_vertical,
              color: Color(0xFFE5E5E5),
              size: 30,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Container(
                  width: double.infinity,
                  height: 600,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE5E5E5),
                    borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(50),
                      topEnd: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Obx(()=> ListView.builder(
                            controller: _scrollController,
                            itemCount:authController.messages.length,
                            reverse: true,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return Align(
                                alignment: authController.messages[index]["senderId"] == authController.currentUser['_id']
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: authController.messages[index]["senderId"] == authController.currentUser['_id']
                                        ? Colors.blue
                                        : const Color(0xFFECDEA7),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Text(
                                    authController.messages[index]['content'],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                       Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, bottom: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 60,
                                child: Form(
                                  child: TextFormField(
                                    onChanged: (val)=>setState(() {
                                      content=val;
                                    }),
                                    decoration: InputDecoration(
                                      prefixIcon: const Padding(
                                        padding: EdgeInsets.all(4.0),
                                        child: Icon(
                                          Icons.emoji_emotions,
                                          size: 50,
                                          color: Colors.lightBlue,
                                        ),
                                      ),
                                      hintText: 'message',
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(100),
                                        ),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(100),
                                        ),
                                      ),
                                      suffixIcon:Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 4.0),
                                            child: IconButton(onPressed: (){} , icon: Icon(Icons.attach_file),),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              color: Colors.lightBlue,
                                              borderRadius: BorderRadius.circular(100)
                                            ),
                                            child: content.isEmpty ? Text(""): IconButton(
                                              onPressed: (){
                                                dynamic messa={
                                                  'conversationId': authController.conversations['_id'],
                                                  "senderId": authController.currentUser['_id'],
                                                   "content": content,
                                                  "receiverId": widget.user['_id']
                                                };
                                                String token=authController.token.value;
                                                authController.createMessages(messa, token);
                                              },
                                              icon: Icon(Icons.send),
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(width: 4,)
                                        ],
                                      )
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
