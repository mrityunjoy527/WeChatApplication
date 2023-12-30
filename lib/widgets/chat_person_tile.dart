import 'package:flutter/material.dart';
import 'package:we_chat/Screens/chat_room.dart';
import 'package:we_chat/firebase/firebase_firestore/firebase_firestore_options.dart';
import 'package:we_chat/firebase/models/user_model.dart';

class ChatPersonTile extends StatelessWidget {
  final UserModel model;
  final String myUid;
  const ChatPersonTile({super.key, required this.model, required this.myUid});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
       Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatRoomScreen(userUid: model.myUid, myUid: myUid, user: model.username,)));
      },
      child: Container(
        margin: const EdgeInsets.only(top: 6, left: 6, right: 6),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.cyan.shade200,
              Colors.cyan,
              Colors.cyanAccent,
            ],
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2,
            ),
          ],
          border: Border.all(color: Colors.grey,),
          borderRadius: BorderRadius.circular(6),
        ),
        child: ListTile(
          title: Text(model.username),
          leading: Icon(
            Icons.person,
            color: Colors.grey.shade700,
          ),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            color: Colors.grey.shade700,
          ),
        ),
      ),
    );
  }
}
