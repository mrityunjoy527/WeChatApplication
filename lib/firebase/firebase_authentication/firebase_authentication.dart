import 'package:we_chat/firebase/models/firebase_user_model.dart';

abstract class FirebaseAuthentication {

  Future<FirebaseUserModel?> signIn({
    required String email,
    required String password,
  });

  Future<FirebaseUserModel?> signUp({
    required String username,
    required String email,
    required String password,
  });

  Future<void> logOut();

  Future<String?> sendEmailVerification();

  Future<void> sendPasswordResetLink({
    required String email,
  });

  FirebaseUserModel? giveUser();
}
