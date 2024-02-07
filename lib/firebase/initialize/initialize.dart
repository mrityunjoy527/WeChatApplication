import 'package:we_chat/firebase/initialize/initialize_firebase.dart';
import 'package:we_chat/firebase/initialize/initialize_firebase_provider.dart';
import 'package:we_chat/firebase/models/firebase_user_model.dart';

class Initialize extends InitializeFirebase {
  final InitializeFirebaseProvider provider;

  Initialize.fromFirebase(this.provider);

  @override
  Future<FirebaseUserModel?> initialize() => provider.initialize();
}
