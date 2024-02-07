import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_chat/exceptions/auth_exceptions.dart';
import 'package:we_chat/firebase/firebase_authentication/firebase_authentication.dart';
import 'package:we_chat/firebase/firebase_firestore/firebase_firestore_provider.dart';
import 'package:we_chat/firebase/firebase_firestore/firestore.dart';
import 'package:we_chat/firebase/models/firebase_user_model.dart';

class FirebaseAuthenticationProvider extends FirebaseAuthentication {
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.fromFirebase(FirebaseFirestoreProvider());

  @override
  Future<void> logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('email');
    preferences.remove('uid');
    preferences.remove('emailVerified');
    await _auth.signOut();
  }

  @override
  Future<void> sendPasswordResetLink({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    }on FirebaseAuthException catch(e) {
      switch(e.code) {
        case 'invalid-email': throw InvalidEmailAuthException();
        case 'user-not-found': throw UserNotFountAuthException();
        default: throw GeneralAuthException();
      }
    } catch(e) {
      throw GeneralAuthException();
    }
  }

  @override
  Future<FirebaseUserModel?> signIn(
      {required String email, required String password}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = result.user;
      if (user == null) {
        return null;
      } else {
        final person = giveUser();
        preferences.setString('email', person!.email);
        preferences.setString('uid', person.uid);
        preferences.setBool('emailVerified', person.emailVerified);
        return person;
      }
    } on FirebaseAuthException catch (e) {
      switch(e.code) {
        case "invalid-credential": throw WrongPasswordAuthException();
        case "invalid-email": throw InvalidEmailAuthException();
        case "user-not-found": throw UserNotFountAuthException();
        default: throw GeneralAuthException();
      }
    }
  }

  @override
  Future<FirebaseUserModel?> signUp(
      {required String username,
      required String email,
      required String password}) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = result.user;
      if (user == null) {
        return null;
      } else {
        await _firestore.createUser(uid: user.uid, username: username);
        return giveUser();
      }
    } on FirebaseAuthException catch (e) {
      switch(e.code) {
        case "invalid-email": throw InvalidEmailAuthException();
        case "email-already-in-use": throw EmailAlreadyInUseAuthException();
        case "weak-password": throw WeakPasswordAuthException();
        default: throw GeneralAuthException();
      }
    } catch (e) {
      throw GeneralAuthException();
    }
  }

  @override
  FirebaseUserModel? giveUser() {
    final user = _auth.currentUser;
    if (user != null) {
      return FirebaseUserModel(
          uid: user.uid, email: user.email!, emailVerified: user.emailVerified);
    }
    return null;
  }

  @override
  Future<String?> sendEmailVerification() async {
    final user = _auth.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
      return user.email!;
    }
    return null;
  }
}
