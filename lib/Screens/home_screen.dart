import 'package:flutter/material.dart';
import 'package:we_chat/Screens/login_screen.dart';
import 'package:we_chat/firebase/firebase_authentication/firebase_authentication.dart';
import 'package:we_chat/firebase/firebase_firestore/firebase_firestore_options.dart';
import 'package:we_chat/widgets/chat_person_tile.dart';

class HomeScreen extends StatefulWidget {
  final String myUid;

  const HomeScreen({super.key, required this.myUid});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseFirestoreOptions usersList = FirebaseFirestoreOptions();
  final _authProvider = FirebaseAuthentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Let's chat"),
        backgroundColor: Colors.cyan,
        elevation: 3.0,
        actions: [
          IconButton(
            onPressed: () async {
              await _authProvider.logOut();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: FutureBuilder(
        future: usersList.getAllUsers(myUid: widget.myUid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final list = snapshot.data ?? [];
              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return ChatPersonTile(
                    model: list.elementAt(index),
                    myUid: widget.myUid,
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
