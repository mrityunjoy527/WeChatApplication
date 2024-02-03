import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String text;
  final bool sendByMe;
  final String time;

  ChatModel({required this.time, required this.text, required this.sendByMe});

  ChatModel.fromFirebase(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : text = snapshot['text'] as String,
        sendByMe = snapshot['sendByMe'] as bool,
        time = snapshot['time'] as String;
}
