import 'package:flutter/material.dart';
import 'package:we_chat/firebase/firebase_firestore/firebase_firestore_provider.dart';
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
  final firestore = FirebaseFirestoreProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      padding: const EdgeInsets.all(8),
                      height: MediaQuery.of(context).size.height -
                          kToolbarHeight -
                          kBottomNavigationBarHeight -
                          35,
                      child: ListView.builder(
                        reverse: true,
                        itemCount: chats.length,
                        itemBuilder: (context, index) {
                          return ChatTile(model: chats.elementAt(index));
                        },
                      ),
                    );
                  } else {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height -
                          kToolbarHeight -
                          kBottomNavigationBarHeight -
                          35,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  case ConnectionState.none:
                  case ConnectionState.done:
                  default:
                    return SizedBox(
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
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width - 70,
                    maxHeight: 150,
                  ),
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    controller: message,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter your message ....',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.cyan.shade700,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.cyan.shade700,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: kToolbarHeight+10,
                  height: kToolbarHeight+10,
                  decoration: BoxDecoration(
                    color: Colors.cyan,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: IconButton(
                    onPressed: () async {
                      final text = message.text;
                      message.text = "";
                      if (text.isNotEmpty) {
                        await firestore.createChatRoom(
                            myUid: widget.myUid,
                            userUid: widget.userUid,
                            text: text);
                      }
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
