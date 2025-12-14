part of 'test_bloc.dart';

abstract class TestEvent {}

class TestInitialized extends TestEvent {}

class TestLoaded extends TestEvent {
  final List<LabTest> tests;

  TestLoaded({required this.tests});
}

class TestFetchFailed extends TestEvent {
  final String message;

  TestFetchFailed({required this.message});
}

class TestAddEvent extends TestEvent {
  final LabTest test;

  TestAddEvent({required this.test});
}

class TestRemoveEvent extends TestEvent {
  final String testId;

  TestRemoveEvent({required this.testId});
}

class TestUpdateEvent extends TestEvent {
  final LabTest test;

  TestUpdateEvent({required this.test});
}
