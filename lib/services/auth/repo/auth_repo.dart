import 'package:certispec/services/auth/data_source/auth_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthRepository {
  Future<UserCredential> loginWithEmailPassword({
    required String email,
    required String password,
  });
  Future<void> logout();

  Future<UserCredential> registerWithEmailPassword({
    required String email,
    required String password,
  });

  // Future<void> saveUser(String uid, String email);

  String? get userId;
  String? get email;
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSourceRepository authDataSourceRepository;

  AuthRepositoryImpl(this.authDataSourceRepository);
  @override
  String? get email => authDataSourceRepository.email;
  @override
  String? get userId => authDataSourceRepository.userId;

  @override
  Future<UserCredential> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    final res = authDataSourceRepository.loginWithEmailPassword(
      email: email,
      password: password,
    );
    return res;
  }

  @override
  Future<void> logout() async {
    await authDataSourceRepository.logout();
  }

  @override
  Future<UserCredential> registerWithEmailPassword({
    required String email,
    required String password,
  }) async {
    final res = await authDataSourceRepository.registerWithEmailPassword(
      email: email,
      password: password,
    );
    return res;
  }
}
