part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileStateLoading extends ProfileState {}

class ProfileStateSuccess extends ProfileState {
  final Map<String, dynamic> data;

  ProfileStateSuccess(this.data);
}

class ProfileFormStateSuccess extends ProfileState {
  final Map<String, dynamic> data;

  ProfileFormStateSuccess(this.data);
}

class ProfileStateError extends ProfileState {
  final Map<String, dynamic> errors;

  ProfileStateError(this.errors);
}
