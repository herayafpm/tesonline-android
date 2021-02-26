part of 'test_bloc.dart';

@immutable
abstract class TestEvent {}

class TestGetListEvent extends TestEvent {
  final bool refresh;

  TestGetListEvent({this.refresh = false});
}
