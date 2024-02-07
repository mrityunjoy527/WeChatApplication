import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_chat/firebase/initialize/initialize_firebase.dart';
import 'package:we_chat/firebase/models/firebase_user_model.dart';
import 'package:we_chat/ignoreFolder/firebase_options.dart';

class InitializeFirebaseProvider extends InitializeFirebase{
  @override
  Future<FirebaseUserModel?> initialize() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final savedEmail = preferences.getString('email');
    final savedUid = preferences.getString('uid');
    final savedEmailVerified = preferences.getBool('emailVerified');
    if(savedEmail != null) {
      return FirebaseUserModel(uid: savedUid!, email: savedEmail, emailVerified: savedEmailVerified!);
    }
    return null;
  }
}