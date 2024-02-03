import 'package:firebase_core/firebase_core.dart';
import 'package:we_chat/firebase/initialize/initialize_firebase.dart';
import 'package:we_chat/ignoreFolder/firebase_options.dart';

class InitializeFirebaseProvider extends InitializeFirebase{
  @override
  Future<void> initialize() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  }

}