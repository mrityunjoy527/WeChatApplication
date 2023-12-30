import 'package:flutter/material.dart';
import 'package:we_chat/Screens/login_screen.dart';
import 'package:we_chat/firebase/firebase_authentication/firebase_authentication.dart';
import 'package:we_chat/firebase/firebase_firestore/firebase_firestore_options.dart';
import 'package:we_chat/firebase/models/user_model.dart';
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
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const LoginScreen()));
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: StreamBuilder<Iterable<UserModel>>(
          stream: usersList.getAllUsers(myUid: widget.myUid),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.active:
                if (snapshot.hasData) {
                  final users = snapshot.data ?? [];
                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      return ChatPersonTile(
                        model: users.elementAt(index),
                        myUid: widget.myUid,
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              case ConnectionState.none:
              case ConnectionState.done:
              default:
                return const Center(
                  child: CircularProgressIndicator(),
                );
            }
          },
        ));
  }
}
