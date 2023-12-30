import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:we_chat/Screens/chat_room.dart";
import "package:we_chat/Screens/home_screen.dart";
import "package:we_chat/Screens/login_screen.dart";
import "package:we_chat/Screens/register_screen.dart";
import 'package:we_chat/ignoreFolder/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
