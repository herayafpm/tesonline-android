part of 'user_soal_bloc.dart';

@immutable
abstract class UserSoalEvent {}

class UserSoalsGetEvent extends UserSoalEvent {}

class UserSoalGetEvent extends UserSoalEvent {
  final int id;

  UserSoalGetEvent(this.id);
}

class UserSoalUbahEvent extends UserSoalEvent {
  final UserModel user;

  UserSoalUbahEvent(this.user);
}
