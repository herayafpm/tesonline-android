part of 'ubah_password_bloc.dart';

@immutable
abstract class UbahPasswordState {}

class UbahPasswordInitial extends UbahPasswordState {}

class UbahPasswordStateLoading extends UbahPasswordState {}

class UbahPasswordStateSuccess extends UbahPasswordState {
  final Map<String, dynamic> data;

  UbahPasswordStateSuccess(this.data);
}

class UbahPasswordStateError extends UbahPasswordState {
  final Map<String, dynamic> errors;

  UbahPasswordStateError(this.errors);
}
