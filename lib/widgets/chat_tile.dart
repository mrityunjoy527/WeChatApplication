import 'package:flutter/material.dart';
import 'package:we_chat/firebase/models/chat_model.dart';

class ChatTile extends StatelessWidget {
  final ChatModel model;
  const ChatTile({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
      margin: EdgeInsets.only(
        top: 12,
        left: model.sendByMe? 100: 0,
        right: model.sendByMe? 0: 100,
      ),
      decoration: BoxDecoration(
        color: model.sendByMe ? Colors.cyan : Colors.cyan.shade200,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20),
          bottomLeft: Radius.circular(
            model.sendByMe ? 20 : 0,
          ),
          bottomRight: Radius.circular(
            model.sendByMe ? 0 : 20,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment:  model.sendByMe ? CrossAxisAlignment.end: CrossAxisAlignment.start,
        children: [
          Text(
            model.text,
            textAlign: model.sendByMe ? TextAlign.end : TextAlign.start,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          Text(
            model.time,
            textAlign: model.sendByMe ? TextAlign.end : TextAlign.start,
            style: const TextStyle(
              color: Colors.black38,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
