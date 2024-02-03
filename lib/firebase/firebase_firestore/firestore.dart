import 'package:we_chat/firebase/firebase_firestore/firebase_firestore_options.dart';
import 'package:we_chat/firebase/firebase_firestore/firebase_firestore_provider.dart';
import 'package:we_chat/firebase/models/chat_model.dart';
import 'package:we_chat/firebase/models/user_model.dart';

class Firestore extends FirebaseFirestoreOptions {
  final FirebaseFirestoreProvider provider;

  Firestore.fromFirebase(this.provider);

  @override
  Future<void> createChatRoom({
    required String myUid,
    required String userUid,
    required String text,
  }) =>
      provider.createChatRoom(myUid: myUid, userUid: userUid, text: text);

  @override
  Future<void> createUser({
    required String uid,
    required String username,
  }) =>
      provider.createUser(uid: uid, username: username);

  @override
  Stream<Iterable<UserModel>> getAllUsers({
    required String myUid,
  }) =>
      provider.getAllUsers(myUid: myUid);

  @override
  Stream<Iterable<ChatModel>> getChats({
    required String myUid,
    required String userUid,
  }) =>
      provider.getChats(myUid: myUid, userUid: userUid);
}
