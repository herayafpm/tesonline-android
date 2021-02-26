part of 'user_test_bloc.dart';

@immutable
abstract class UserTestEvent {}

class UserTestGetEvent extends UserTestEvent {}

class UserTestPostEvent extends UserTestEvent {
  final Map<String, dynamic> json;

  UserTestPostEvent(this.json);
}
