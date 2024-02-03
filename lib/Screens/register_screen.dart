import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../dialogs/show_error_dialog.dart';
import '../dialogs/show_general_error_dialog.dart';
import '../exceptions/auth_exceptions.dart';
import '../we_chat_bloc/we_chat_bloc.dart';

class RegisterScreen extends StatefulWidget {
  final String? username;
  final String? email;
  final String? password;
  const RegisterScreen({super.key, this.username, this.email, this.password});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _usernameController;
  bool show = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    _emailController.text = widget.email ?? "";
    _passwordController = TextEditingController();
    _passwordController.text = widget.password ?? "";
    _usernameController = TextEditingController();
    _usernameController.text = widget.username ?? "";
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign Up",
        ),
        backgroundColor: Colors.cyan,
        elevation: 3.0,
      ),
      body: BlocListener<WeChatBloc, WeChatState>(
        listener: (context, state) {
          if(state is WeChatRegisteringState && state.exception != null) {
            switch(state.exception.runtimeType) {
              case InvalidEmailAuthException: showErrorDialog(context: context, title: 'Invalid email!', content: 'Please try a valid email');
              break;
              case WeakPasswordAuthException: showErrorDialog(context: context, title: 'Weak password!', content: 'Password length should be more than 5');
              break;
              case EmailAlreadyInUseAuthException: showErrorDialog(context: context, title: 'Already registered!', content: 'Email already in use');
              break;
              default: showGeneralErrorDialog(context: context);
            }
          }
        },
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: 'Enter your username',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(
                        color: Colors.cyan, width: 7.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.cyan.shade100,
                      width: 3,
                    ),
                  ),
                ),
              ),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(
                        color: Colors.cyan, width: 7.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.cyan.shade100,
                      width: 3,
                    ),
                  ),
                ),
              ),
              TextField(
                controller: _passwordController,
                obscureText: !show,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        show = !show;
                      });
                    },
                    icon: Icon(
                      show ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                  hintText: 'Enter your password',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(
                        color: Colors.cyan, width: 7.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.cyan.shade100,
                      width: 3,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () {
                  String email = _emailController.text;
                  String password = _passwordController.text;
                  String username = _usernameController.text;
                  context.read<WeChatBloc>().add(RegisterWeChatEvent(
                      username: username, password: password, email: email));
                },
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.cyan.shade600,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  context
                      .read<WeChatBloc>()
                      .add(const LogOutWeChatEvent());
                },
                child: Text(
                  "Already Registered?",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.cyan.shade600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
