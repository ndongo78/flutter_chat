import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ChatScreen extends StatefulWidget {
  Map user = {};

  ChatScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     widget.user['name'],
      //     style: TextStyle(fontSize: 20),
      //   ),
      //   leading: Padding(
      //     padding: const EdgeInsets.only(left: 4.0),
      //     child: CircleAvatar(
      //       backgroundColor: Colors.black,
      //       radius: 40,
      //       child: ClipOval(
      //         child: Image.network(
      //           widget.user['avatar'],
      //           fit: BoxFit.cover,
      //           width: 100,
      //           height: 150,
      //         ),
      //       ),
      //     ),
      //   ),
      //   actions: [
      //     IconButton(
      //       onPressed: () {},
      //       icon: Icon(Ionicons.videocam_outline),
      //       color: Colors.white,
      //       iconSize: 35,
      //     ),
      //     IconButton(
      //       onPressed: () {},
      //       icon: Icon(Ionicons.call_outline),
      //       color: Colors.white,
      //       iconSize: 30,
      //     ),
      //   ],
      // ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 25),
                      child: IconButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Color(0xFF4B4237),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Ionicons.chevron_back),
                        color: Color(0xFFE5E5E5),
                        iconSize: 30,
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 35,
                      child: ClipOval(
                        child: Image.network(
                          widget.user['avatar'],
                          fit: BoxFit.cover,
                          width: 100,
                          height: 150,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            widget.user['name'],
                            style: const TextStyle(
                                color: Color(0xFFE5E5E5), fontSize: 20),
                          ),
                          const Text.rich(
                            TextSpan(
                              text: 'En ligne ',
                              style: TextStyle(
                                color: Color(0xFF4B4237),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Ionicons.ellipsis_vertical, color: Color(0xFFE5E5E5),size: 30,),
                )
              ],
            ),
            // fin header

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
                child: Text('messahe'),
              ),
            )


          ],
        ),
      ),
    );
  }
}
