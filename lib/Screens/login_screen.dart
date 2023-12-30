import 'package:flutter/material.dart';
import 'package:we_chat/Screens/home_screen.dart';
import 'package:we_chat/Screens/register_screen.dart';
import 'package:we_chat/firebase/firebase_authentication/firebase_authentication.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authProvider = FirebaseAuthentication();

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
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
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
                final res = await _authProvider.signIn(email, password);
                if(res != null) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen(myUid: res.uid,)));
                }
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
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const RegisterScreen()));
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
    );
  }
}
