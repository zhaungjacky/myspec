import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:certispec/models/lab_test.dart';
import 'package:certispec/services/repository/data_source.dart';
import 'package:flutter/material.dart';

part 'test_event.dart';
part 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  late StreamSubscription _streamSubscription;
  final DataSource<LabTest> _dataSource;

  TestBloc({required DataSource<LabTest> dataSource})
    : _dataSource = dataSource,
      super(TestsInitial()) {
    _streamSubscription = _dataSource.getItems().listen((event) {
      final tests = event.docs.map((map) => LabTest.fromJson(map)).toList();
      // print(tests[0].method);
      add(TestLoaded(tests: tests));
    });
    on<TestInitialized>((_, emit) {
      emit(TestsInitial());
    });
    on<TestLoaded>((event, emit) {
      emit(TestsLoadSuccess(event.tests));
    });
    on<TestFetchFailed>((event, emit) {
      emit(TestsLoadFailure(event.message));
    });
    on<TestAddEvent>((event, emit) async {
      await _dataSource.createItem(event.test);
    });
    on<TestRemoveEvent>((event, emit) async {
      await _dataSource.delItem(event.testId);
    });
    on<TestUpdateEvent>((event, emit) async {
      await _dataSource.updateItem(event.test);
    });
  }
  @override
  Future<void> close() async {
    super.close();
    await _streamSubscription.cancel();
  }
}
