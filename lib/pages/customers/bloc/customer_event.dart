part of 'customer_bloc.dart';

@immutable
sealed class CustomerEvent {}

final class CustomersInit extends CustomerEvent {}

final class CustomersLoaded extends CustomerEvent {
  final List<CustomerInfo> customers;
  CustomersLoaded({required this.customers});
}

final class CustomersError extends CustomerEvent {
  final String message;
  CustomersError({required this.message});
}

final class CustomersRefresh extends CustomerEvent {}

final class CustomerAdd extends CustomerEvent {
  final CustomerInfo customer;
  CustomerAdd({required this.customer});
}

final class CustomerUpdate extends CustomerEvent {
  final CustomerInfo customer;
  CustomerUpdate({required this.customer});
}

final class CustomerDelete extends CustomerEvent {
  final String id;
  CustomerDelete({required this.id});
}

final class CustomerEmpty extends CustomerEvent {
  final String message;
  CustomerEmpty({required this.message});
}
