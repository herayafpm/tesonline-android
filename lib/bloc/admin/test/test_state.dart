part of 'test_bloc.dart';

@immutable
abstract class TestState {}

class TestInitial extends TestState {}

class TestStateLoading extends TestState {}

class TestStateSuccess extends TestState {
  final Map<String, dynamic> data;

  TestStateSuccess(this.data);
}

class TestFormSuccess extends TestState {
  final Map<String, dynamic> data;

  TestFormSuccess(this.data);
}

class TestStateError extends TestState {
  final Map<String, dynamic> errors;

  TestStateError(this.errors);
}

class TestListLoaded extends TestState {
  List<dynamic> tests;
  bool hasReachMax;

  TestListLoaded({this.tests, this.hasReachMax});
  TestListLoaded copyWith({List<dynamic> tests, bool hasReachMax}) {
    return TestListLoaded(
        tests: tests ?? this.tests,
        hasReachMax: hasReachMax ?? this.hasReachMax);
  }
}
