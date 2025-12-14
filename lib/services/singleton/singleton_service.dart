import 'package:certispec/models/customer_info.dart';
import 'package:certispec/models/lab_test.dart';
import 'package:certispec/pages/auth/bloc/auth_bloc.dart';
import 'package:certispec/pages/customers/bloc/customer_bloc.dart';
import 'package:certispec/pages/tests/bloc/test_bloc.dart';
import 'package:certispec/services/auth/data_source/auth_data_source.dart';
import 'package:certispec/services/auth/repo/auth_repo.dart';
import 'package:certispec/services/customers/customer_impl.dart';
import 'package:certispec/services/lab/lab_repo_impl.dart';
import 'package:certispec/services/repository/data_source.dart';
import 'package:get_it/get_it.dart';

GetIt singleton = GetIt.instance;

Future<void> initSingleton() async {
  _initAuth();
}

void _initAuth() {
  singleton.registerFactory<AuthDataSourceRepository>(
    () => AuthDatasourceRepositoryImpl(),
  );
  singleton.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(singleton<AuthDataSourceRepository>()),
  );
  singleton.registerLazySingleton<AuthBloc>(() => AuthBloc());
  _initTestBloc();
  _initCustomerBloc();
}

void _initCustomerBloc() {
  // Register Customer data source
  singleton.registerFactory<DataSource<CustomerInfo>>(() => CustomerInfoImpl());

  // Register CustomerBloc
  singleton.registerLazySingleton<CustomerBloc>(
    () => CustomerBloc(dataSource: singleton<DataSource<CustomerInfo>>()),
  );
}

void _initTestBloc() {
  singleton.registerFactory<DataSource<LabTest>>(() => LabDataImpl());

  singleton.registerLazySingleton<TestBloc>(
    () => TestBloc(dataSource: singleton<DataSource<LabTest>>()),
  );
}
