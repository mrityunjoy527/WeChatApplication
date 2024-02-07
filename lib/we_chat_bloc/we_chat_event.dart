part of 'we_chat_bloc.dart';

@immutable
abstract class WeChatEvent {
  const WeChatEvent();
}

class InitializeAppWeChatEvent extends WeChatEvent {
  const InitializeAppWeChatEvent();
}

class SendEmailVerificationWeChatEvent extends WeChatEvent {
  const SendEmailVerificationWeChatEvent();
}

class LogInWeChatEvent extends WeChatEvent {
  final String email;
  final String password;

  const LogInWeChatEvent({
    required this.email,
    required this.password,
  });
}

class ShouldRegisterWeChatEvent extends WeChatEvent {
  final String? username;
  final String? email;
  final String? password;
  const ShouldRegisterWeChatEvent({this.username, this.email, this.password});
}

class RegisterWeChatEvent extends WeChatEvent {
  final String username;
  final String email;
  final String password;

  const RegisterWeChatEvent({
    required this.username,
    required this.email,
    required this.password,
  });
}

class LogOutWeChatEvent extends WeChatEvent {
  final String? email;
  final String? password;
  const LogOutWeChatEvent({this.email, this.password});
}

class ForgotPasswordEvent extends WeChatEvent {
  final String email;
  const ForgotPasswordEvent({required this.email});
}