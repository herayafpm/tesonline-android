part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginBlocEvent extends LoginEvent {
  final String user_username;
  final String user_password;

  LoginBlocEvent(this.user_username, this.user_password);
}
