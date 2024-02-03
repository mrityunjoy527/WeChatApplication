import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_chat/we_chat_bloc/we_chat_bloc.dart';

class VerificationScreen extends StatefulWidget {
  final String? username;
  final String? password;
  final Function(BuildContext context) addEvent;
  const VerificationScreen({super.key, required this.addEvent, this.username, this.password});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify yourself"),
        backgroundColor: Colors.cyan,
        elevation: 3.0,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          const Text(
            "You can not access your account without verification",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 23,
              color: Colors.red,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Send a verification link to your email",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              context
                  .read<WeChatBloc>()
                  .add(const SendEmailVerificationWeChatEvent());
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            child: const Text(
              "Send",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20.0,),
          TextButton(
            onPressed: () {
              widget.addEvent(context);
            },
            child: Text(
              "Change credentials",
              style: TextStyle(
                fontSize: 20,
                color: Colors.cyan.shade600,
              ),
            ),
          )
        ],
      ),
    );
  }
}
