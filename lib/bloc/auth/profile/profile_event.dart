part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class ProfileGetEvent extends ProfileEvent {}

class ProfileUbahEvent extends ProfileEvent {
  final UserModel user;

  ProfileUbahEvent(this.user);
}
