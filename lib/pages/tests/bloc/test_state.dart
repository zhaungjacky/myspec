part of 'test_bloc.dart';

@immutable
sealed class TestState {
  const TestState();
}

class TestsInitial extends TestState {}

class TestsLoadInProgress extends TestState {}

class TestsLoadSuccess extends TestState {
  final List<LabTest> tests;

  const TestsLoadSuccess(this.tests);
}

class TestsLoadFailure extends TestState {
  final String message;

  const TestsLoadFailure(this.message);
}
