part of 'user_soal_bloc.dart';

@immutable
abstract class UserSoalState {}

class UserSoalInitial extends UserSoalState {}

class UserSoalStateLoading extends UserSoalState {}

class UserSoalStateSuccess extends UserSoalState {
  final Map<String, dynamic> data;

  UserSoalStateSuccess(this.data);
}

class UserSoalsStateSuccess extends UserSoalState {
  final Map<String, dynamic> data;

  UserSoalsStateSuccess(this.data);
}

class UserSoalFormStateSuccess extends UserSoalState {
  final Map<String, dynamic> data;

  UserSoalFormStateSuccess(this.data);
}

class UserSoalStateError extends UserSoalState {
  final Map<String, dynamic> errors;

  UserSoalStateError(this.errors);
}
