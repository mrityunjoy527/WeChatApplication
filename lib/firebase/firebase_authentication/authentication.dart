import 'package:we_chat/firebase/firebase_authentication/firebase_authentication_provider.dart';
import 'package:we_chat/firebase/firebase_authentication/firebase_authentication.dart';
import 'package:we_chat/firebase/models/firebase_user_model.dart';

class Authentication extends FirebaseAuthentication {
  final FirebaseAuthenticationProvider provider;

  Authentication.fromFirebase(this.provider);

  @override
  FirebaseUserModel? giveUser() => provider.giveUser();

  @override
  Future<void> logOut() => provider.logOut();

  @override
  Future<void> sendPasswordResetLink({required String email}) =>
      provider.sendPasswordResetLink(email: email);

  @override
  Future<FirebaseUserModel?> signIn(
          {required String email, required String password}) =>
      provider.signIn(email: email, password: password);

  @override
  Future<FirebaseUserModel?> signUp(
          {required String username,
          required String email,
          required String password}) =>
      provider.signUp(username: username, email: email, password: password);

  @override
  Future<String?> sendEmailVerification() => provider.sendEmailVerification();
}
