import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:we_chat/firebase/firebase_firestore/firebase_firestore_options.dart';
import 'package:we_chat/firebase/models/chat_model.dart';
import 'package:we_chat/widgets/chat_tile.dart';

class ChatRoomScreen extends StatefulWidget {
  final String user;
  final String myUid;
  final String userUid;

  const ChatRoomScreen(
      {super.key,
      required this.myUid,
      required this.userUid,
      required this.user});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final TextEditingController message = TextEditingController();
  final firestore = FirebaseFirestoreOptions();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(widget.user),
        backgroundColor: Colors.cyan,
        elevation: 3.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<Iterable<ChatModel>>(
              stream: firestore.getChats(myUid: widget.myUid, userUid: widget.userUid,),
              builder: (context, snapshot) {
                switch(snapshot.connectionState) {
                  case ConnectionState.active:
                  case ConnectionState.waiting:
                  if (snapshot.hasData) {
                    final chats = snapshot.data ?? [];
                    return Container(
                      padding: EdgeInsets.all(8),
                      height: MediaQuery.of(context).size.height -
                          kToolbarHeight -
                          kBottomNavigationBarHeight -
                          30,
                      child: ListView.builder(
                        reverse: true,
                        itemCount: chats.length,
                        itemBuilder: (context, index) {
                          return ChatTile(model: chats.elementAt(index));
                        },
                      ),
                    );
                  } else {
                    return Container(
                      height: MediaQuery.of(context).size.height -
                          kToolbarHeight -
                          kBottomNavigationBarHeight -
                          30,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  case ConnectionState.none:
                  case ConnectionState.done:
                  default:
                    return Container(
                      height: MediaQuery.of(context).size.height -
                          kToolbarHeight -
                          kBottomNavigationBarHeight -
                          30,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                }
              },
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 60,
                  height: 60,
                  child: TextField(
                    controller: message,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter your message ....',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.cyan.shade700,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.cyan.shade700,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.cyan,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: IconButton(
                    onPressed: () async {
                      final text = message.text;
                      if (text.isNotEmpty) {
                        await firestore.createChatRoom(
                            myUid: widget.myUid,
                            userUid: widget.userUid,
                            text: text);
                      }
                      setState(() {
                        message.text = "";
                      });
                    },
                    icon: const Icon(
                      Icons.send,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
