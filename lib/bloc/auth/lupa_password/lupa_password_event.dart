part of 'lupa_password_bloc.dart';

@immutable
abstract class LupaPasswordEvent {}

class LupaPasswordBlocEvent extends LupaPasswordEvent {
  final String user_username;

  LupaPasswordBlocEvent(this.user_username);
}

class CekKodeEvent extends LupaPasswordEvent {
  final String user_email;
  final int kode_otp;

  CekKodeEvent(this.user_email, this.kode_otp);
}

class UbahPasswordEvent extends LupaPasswordEvent {
  final String user_email;
  final int kode_otp;
  final String user_password;

  UbahPasswordEvent(this.user_email, this.kode_otp, this.user_password);
}
