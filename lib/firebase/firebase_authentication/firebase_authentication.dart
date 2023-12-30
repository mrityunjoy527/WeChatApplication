import 'package:firebase_auth/firebase_auth.dart';
import 'package:we_chat/firebase/firebase_firestore/firebase_firestore_options.dart';
import 'package:we_chat/firebase/models/firebase_user_model.dart';

class FirebaseAuthentication {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestoreOptions();

  FirebaseUserModel giveUser(User user) {
    return FirebaseUserModel(uid: user.uid, email: user.email!);
  }

  Future<FirebaseUserModel?> signIn(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = result.user;
      if (user == null) {
        return null;
      } else {
        return giveUser(user);
      }
    } catch (e) {
      return null;
    }
  }

  Future<FirebaseUserModel?> signUp(
      String username, String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password,);
      final user = result.user;
      if (user == null) {
        return null;
      } else {
        await _firestore.createUser(user.uid, username);
        return giveUser(user);
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> logOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

// Future<FirebaseUserModel?> sendPasswordResetLink(String email, String password) async {
//
// }
}
