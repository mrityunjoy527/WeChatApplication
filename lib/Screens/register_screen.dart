import 'package:flutter/material.dart';
import 'package:we_chat/Screens/login_screen.dart';
import 'package:we_chat/firebase/firebase_authentication/firebase_authentication.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _authProvider = FirebaseAuthentication();

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
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                hintText: 'Enter your username',
                focusedBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(color: Colors.cyan, width: 7.0),
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
                  borderSide: const BorderSide(color: Colors.cyan, width: 7.0),
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
              decoration: InputDecoration(
                hintText: 'Enter your password',
                focusedBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(color: Colors.cyan, width: 7.0),
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
            const SizedBox(height: 30,),
            TextButton(
              onPressed: () async {
                String email = _emailController.text;
                String password = _passwordController.text;
                String username = _usernameController.text;
                final res = await _authProvider.signUp(username, email, password);
                if(res != null) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginScreen()));
                }
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
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginScreen()));
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
    );
  }
}
