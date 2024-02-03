import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_chat/dialogs/show_error_dialog.dart';
import 'package:we_chat/dialogs/show_general_error_dialog.dart';
import 'package:we_chat/exceptions/auth_exceptions.dart';
import 'package:we_chat/we_chat_bloc/we_chat_bloc.dart';

class LoginScreen extends StatefulWidget {
  final String? email;
  final String? password;
  const LoginScreen({super.key, this.email, this.password});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool show = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    _emailController.text = widget.email ?? "";
    _passwordController = TextEditingController();
    _passwordController.text = widget.password ?? "";
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign In",
        ),
        backgroundColor: Colors.cyan,
        elevation: 3.0,
      ),
      body: BlocListener<WeChatBloc, WeChatState>(
        listener: (context, state) {
          if (state is WeChatLoggedOutState && state.exception != null) {
            switch (state.exception.runtimeType) {
              case InvalidEmailAuthException:
                showErrorDialog(
                    context: context,
                    title: 'Invalid email!',
                    content: 'Please try a valid email');
                break;
              case WrongPasswordAuthException:
                showErrorDialog(
                    context: context,
                    title: 'Wrong password!',
                    content: 'Please try with correct password');
                break;
              case UserNotFountAuthException:
                showErrorDialog(
                    context: context,
                    title: 'Not registered!',
                    content: 'Please try to register');
                break;
              default:
                showGeneralErrorDialog(context: context);
            }
          }
        },
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.cyan, width: 7.0),
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
                    borderSide:
                        const BorderSide(color: Colors.cyan, width: 7.0),
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
                  context
                      .read<WeChatBloc>()
                      .add(LogInWeChatEvent(password: password, email: email));
                },
                child: Text(
                  "Sign In",
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
                      .add(const ShouldRegisterWeChatEvent());
                },
                child: Text(
                  "Not Registered?",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.cyan.shade600,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Forgot Password?",
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
