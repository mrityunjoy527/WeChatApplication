import 'package:we_chat/firebase/models/chat_model.dart';
import 'package:we_chat/firebase/models/user_model.dart';

abstract class FirebaseFirestoreOptions {
  Future<void> createUser({
    required String uid,
    required String username,
  });

  Future<void> createChatRoom({
    required String myUid,
    required String userUid,
    required String text,
  });

  Stream<Iterable<ChatModel>> getChats({
    required String myUid,
    required String userUid,
  });

  Stream<Iterable<UserModel>> getAllUsers({
    required String myUid,
  });
}
