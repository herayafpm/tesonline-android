part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class RegisterBlocEvent extends RegisterEvent {
  final UserModel user;

  RegisterBlocEvent(this.user);
}
