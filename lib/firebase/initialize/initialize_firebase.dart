import 'package:we_chat/firebase/models/firebase_user_model.dart';

abstract class InitializeFirebase {
  Future<FirebaseUserModel?> initialize();
}