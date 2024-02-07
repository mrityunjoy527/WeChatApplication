import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_chat/firebase/firebase_authentication/authentication.dart';
import 'package:we_chat/firebase/firebase_authentication/firebase_authentication_provider.dart';
import 'package:we_chat/firebase/initialize/initialize.dart';
import 'package:we_chat/firebase/initialize/initialize_firebase_provider.dart';
import 'package:we_chat/firebase/models/firebase_user_model.dart';
part 'we_chat_event.dart';
part 'we_chat_state.dart';

class WeChatBloc extends Bloc<WeChatEvent, WeChatState> {
  WeChatBloc() : super(const WeChatInitial(isLoading: true)) {
    on<InitializeAppWeChatEvent>((event, emit) async {
      final provider = Initialize.fromFirebase(InitializeFirebaseProvider());
      final user = await provider.initialize();
      if(user != null) {
        emit(WeChatLoggedInState(user: user, isLoading: false));
      } else {
        emit(const WeChatLoggedOutState(exception: null, isLoading: false));
      }
    });

    on<LogInWeChatEvent>((event, emit) async {
      final provider =
          Authentication.fromFirebase(FirebaseAuthenticationProvider());
      emit(const WeChatLoggedOutState(exception: null, isLoading: true));
      try {
        final email = event.email;
        final password = event.password;
        final user = await provider.signIn(email: email, password: password);
        if (user != null) {
          if(!user.emailVerified) {
            emit(WeChatEmailVerifyingState(
              isLoading: false,
              addEvent: (context) {
                context.read<WeChatBloc>().add(LogOutWeChatEvent(email: email, password: password));
              },
            ));
          }else {
            emit(WeChatLoggedInState(user: user, isLoading: false));
          }
        } else {
          emit(const WeChatLoggedOutState(exception: null, isLoading: false));
        }
      }on Exception catch (e) {
        emit(WeChatLoggedOutState(exception: e, isLoading: false));
      }
    });

    on<RegisterWeChatEvent>((event, emit) async {
      final provider =
          Authentication.fromFirebase(FirebaseAuthenticationProvider());
      emit(const WeChatRegisteringState(exception: null, isLoading: true));
      try {
        final username = event.username;
        final email = event.email;
        final password = event.password;
        final user = await provider.signUp(
            username: username, email: email, password: password);
        if (user != null) {
          emit(WeChatEmailVerifyingState(
            isLoading: false,
            username: username,
            addEvent: (context) {
              context.read<WeChatBloc>().add(ShouldRegisterWeChatEvent(username: username, email: email, password: password));
            },
          ));
        } else {
          emit(const WeChatRegisteringState(exception: null, isLoading: false));
        }
      } on Exception catch (e) {
        emit(WeChatRegisteringState(exception: e, isLoading: false));
      }
    });

    on<ShouldRegisterWeChatEvent>((event, emit) {
      emit(WeChatRegisteringState(exception: null, isLoading: false, email: event.email, username: event.username, password: event.password));
    });

    on<LogOutWeChatEvent>((event, emit) async {
      final provider =
          Authentication.fromFirebase(FirebaseAuthenticationProvider());
      await provider.logOut();
      emit(WeChatLoggedOutState(exception: null, isLoading: false, email: event.email, password: event.password));
    });

    on<SendEmailVerificationWeChatEvent>((event, emit) async {
      emit(WeChatEmailVerifyingState(isLoading: true, addEvent: (context){}));
      final provider =
          Authentication.fromFirebase(FirebaseAuthenticationProvider());
      final email = await provider.sendEmailVerification();
      emit(WeChatLoggedOutState(
          exception: null, isLoading: false, email: email));
    });

    on<ForgotPasswordEvent>((event, emit) async {
      emit(const WeChatLoggedOutState(exception: null, isLoading: true));
      final provider =
      Authentication.fromFirebase(FirebaseAuthenticationProvider());
      try {
        await provider.sendPasswordResetLink(email: event.email);
        emit(const WeChatLoggedOutState(exception: null, isLoading: false, sendPasswordResetLink: true));
      }on Exception catch(e) {
        emit(WeChatLoggedOutState(exception: e, isLoading: false, sendPasswordResetLink: false));
      }
    });
  }
}
