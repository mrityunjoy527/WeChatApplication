import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:we_chat/Screens/home_screen.dart";
import "package:we_chat/Screens/login_screen.dart";
import "package:we_chat/Screens/register_screen.dart";
import "package:we_chat/Screens/verification_screen.dart";
import "package:we_chat/loading/loading_screen.dart";
import "package:we_chat/we_chat_bloc/we_chat_bloc.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(BlocProvider<WeChatBloc>(
    create: (context) => WeChatBloc(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<WeChatBloc>().add(const InitializeAppWeChatEvent());
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocConsumer<WeChatBloc, WeChatState>(
        listener: (context, state) {
          if(state.isLoading) {
            LoadingScreen().show(context: context, text: state.loadingText ?? "Please wait a moment...");
          }else if(!state.isLoading) {
            LoadingScreen().hide();
          }
        },
        builder: (context, state) {
          if(state is WeChatLoggedOutState) {
            return LoginScreen(email: state.email, password: state.password,);
          }else if(state is WeChatEmailVerifyingState){
            return VerificationScreen(addEvent: state.addEvent, username: state.username,);
          }else if(state is WeChatRegisteringState)  {
            return RegisterScreen(username: state.username, email: state.email, password: state.password,);
          }else {
            switch(state.runtimeType) {
              case WeChatLoggedInState:
                return const HomeScreen();
              default:
                return const Center(child: CircularProgressIndicator(),);
            }
          }
        },
      ),
    );
  }
}
