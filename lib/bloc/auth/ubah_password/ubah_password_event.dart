part of 'ubah_password_bloc.dart';

@immutable
abstract class UbahPasswordEvent {}

class UbahPasswordBlocEvent extends UbahPasswordEvent {
  final String user_password;

  UbahPasswordBlocEvent(this.user_password);
}
