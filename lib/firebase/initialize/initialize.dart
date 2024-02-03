import 'package:we_chat/firebase/initialize/initialize_firebase.dart';
import 'package:we_chat/firebase/initialize/initialize_firebase_provider.dart';

class Initialize extends InitializeFirebase {
  final InitializeFirebaseProvider provider;

  Initialize.fromFirebase(this.provider);

  @override
  Future<void> initialize() => provider.initialize();
}
