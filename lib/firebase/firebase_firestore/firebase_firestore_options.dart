import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:we_chat/firebase/models/chat_model.dart';
import 'package:we_chat/firebase/models/user_model.dart';

class FirebaseFirestoreOptions {
  final _db = FirebaseFirestore.instance;

  Future<void> createUser(String uid, String username) async {
    await _db.collection("users").doc(uid).set({
      "username": username,
    });
  }

  Future<void> createChatRoom({
    required String myUid,
    required String userUid,
    required String text,
  }) async {
    final chatId1 = (myUid + userUid);
    final chatId2 = (userUid + myUid);
    await _db.collection("chatRoom").doc(chatId1).collection("chats").add({
      "text": text,
      "sendByMe": true,
      "time": DateFormat().format(DateTime.now()),
    });
    await _db.collection("chatRoom").doc(chatId2).collection("chats").add({
      "text": text,
      "sendByMe": false,
      "time": DateFormat().format(DateTime.now()),
    });
  }

  Stream<Iterable<ChatModel>> getChats({
    required String myUid,
    required String userUid,
  }) {
    final chatId = (myUid + userUid);
    final stream = _db.collection("chatRoom").doc(chatId).collection('chats').orderBy('time', descending: true).snapshots();
    return stream.map((event) => event.docs.map((e) => ChatModel.fromFirebase(e)));
  }

  Stream<Iterable<UserModel>> getAllUsers({required String myUid}) {
    final users = _db.collection("users").snapshots().map(
          (event) =>
          event.docs
              .where((element) => element.id != myUid)
              .map(
                (doc) => UserModel.fromFirebase(doc),
          ),
    );
    return users;
  }
}
