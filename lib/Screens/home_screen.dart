import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_chat/firebase/firebase_authentication/authentication.dart';
import 'package:we_chat/firebase/firebase_authentication/firebase_authentication_provider.dart';
import 'package:we_chat/firebase/firebase_firestore/firebase_firestore_provider.dart';
import 'package:we_chat/firebase/firebase_firestore/firestore.dart';
import 'package:we_chat/firebase/models/user_model.dart';
import 'package:we_chat/we_chat_bloc/we_chat_bloc.dart';
import 'package:we_chat/widgets/chat_person_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = Authentication.fromFirebase(FirebaseAuthenticationProvider()).giveUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Let's chat"),
        backgroundColor: Colors.cyan,
        elevation: 3.0,
        actions: [
          IconButton(
            onPressed: () {
              context.read<WeChatBloc>().add(const LogOutWeChatEvent());
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: StreamBuilder<Iterable<UserModel>>(
        stream: Firestore.fromFirebase(FirebaseFirestoreProvider())
            .getAllUsers(myUid: user!.uid),
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
                      myUid: user!.uid,
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
      ),
    );
  }
}
