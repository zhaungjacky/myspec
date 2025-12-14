part of 'customer_bloc.dart';

@immutable
sealed class CustomerState {}

final class CustomerInitial extends CustomerState {}

final class CustomerLoading extends CustomerState {}

final class CustomerLoaded extends CustomerState {
  final List<CustomerInfo> customers;

  CustomerLoaded({required this.customers});
}

final class CustomerError extends CustomerState {
  final String message;

  CustomerError({required this.message});
}

final class CustomerZero extends CustomerState {
  final String message;

  CustomerZero({required this.message});
}
