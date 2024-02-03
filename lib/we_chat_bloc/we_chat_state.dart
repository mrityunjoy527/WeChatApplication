part of 'we_chat_bloc.dart';

@immutable
abstract class WeChatState {
  final bool isLoading;
  final String? loadingText;

  const WeChatState({
    required this.isLoading,
    this.loadingText = "Please wait a moment",
  });
}

class WeChatInitial extends WeChatState {
  const WeChatInitial({
    required bool isLoading,
  }) : super(isLoading: isLoading);
}

class WeChatLoggedOutState extends WeChatState with EquatableMixin {
  final Exception? exception;
  final String? email;
  final String? password;

  const WeChatLoggedOutState({
    required this.exception,
    required bool isLoading,
    String? loadingText,
    this.email,
    this.password,
  }) : super(isLoading: isLoading);

  @override
  List<Object?> get props => [exception, isLoading];
}

class WeChatRegisteringState extends WeChatState {
  final Exception? exception;
  final String? email;
  final String? username;
  final String? password;

  const WeChatRegisteringState({
    required this.exception,
    required bool isLoading,
    this.email,
    this.username,
    this.password,
  }) : super(isLoading: isLoading);
}

class WeChatLoggedInState extends WeChatState {
  final FirebaseUserModel user;

  const WeChatLoggedInState({
    required this.user,
    required bool isLoading,
  }) : super(isLoading: isLoading);
}

class WeChatForgotPasswordState extends WeChatState {
  const WeChatForgotPasswordState({
    required bool isLoading,
  }) : super(isLoading: isLoading);
}

class WeChatEmailVerifyingState extends WeChatState {
  final String? username;
  final String? password;
  final Function(BuildContext context) addEvent;
  const WeChatEmailVerifyingState({required this.addEvent, required bool isLoading, this.username, this.password})
      : super(isLoading: isLoading);
}
