// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:certispec/models/customer_info.dart';
import 'package:certispec/services/repository/data_source.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:meta/meta.dart';

part 'customer_event.dart';
part 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  late StreamSubscription _streamSubscription;
  final DataSource<CustomerInfo> _dataSource;
  CustomerBloc({required DataSource<CustomerInfo> dataSource})
    : _dataSource = dataSource,
      super(CustomerInitial()) {
    _streamSubscription = _dataSource.getItems().listen((event) {
      final customers = event.docs
          .map((map) => CustomerInfo.fromMap(map))
          .toList();
      // print(customers[0].name);
      add(CustomersLoaded(customers: customers));
    });
    on<CustomerEvent>((_, emit) => emit(CustomerInitial()));
    on<CustomerAdd>((event, emit) async {
      try {
        await _dataSource.createItem(event.customer);
      } on FirebaseException catch (e) {
        emit(CustomerError(message: e.message ?? 'Unknown error'));
      }
    });

    on<CustomerUpdate>((event, emit) async {
      try {
        await _dataSource.updateItem(event.customer);
      } on FirebaseException catch (e) {
        emit(CustomerError(message: e.message ?? 'Unknown error'));
      }
    });
    on<CustomerDelete>((event, emit) async {
      try {
        await _dataSource.delItem(event.id);
      } on FirebaseException catch (e) {
        emit(CustomerError(message: e.message ?? 'Unknown error'));
      }
    });
    on<CustomersRefresh>((_, emit) async {
      await _streamSubscription.cancel();
      _streamSubscription = _dataSource.getItems().listen((event) {
        final customers = event.docs
            .map((map) => CustomerInfo.fromMap(map))
            .toList();
        add(CustomersLoaded(customers: customers));
      });
    });
    on<CustomersLoaded>((event, emit) {
      if (event.customers.isEmpty) {
        emit(CustomerZero(message: 'No customers found.'));
      } else {
        emit(CustomerLoaded(customers: event.customers));
      }
    });
  }

  @override
  Future<void> close() async {
    super.close();
    await _streamSubscription.cancel();
  }
}
