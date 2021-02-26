part of 'user_test_bloc.dart';

@immutable
abstract class UserTestState {}

class UserTestInitial extends UserTestState {}

class UserTestStateLoading extends UserTestState {}

class UserTestStateSuccess extends UserTestState {
  final Map<String, dynamic> data;

  UserTestStateSuccess(this.data);
}

class UserTestFormStateSuccess extends UserTestState {
  final Map<String, dynamic> data;

  UserTestFormStateSuccess(this.data);
}

class UserTestStateError extends UserTestState {
  final Map<String, dynamic> errors;

  UserTestStateError(this.errors);
}
