// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late final StreamSubscription _subscription;

  AuthBloc() : super(AuthInitial()) {
    _subscription = FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event != null) {
        add(AuthLoginEvent(user: event));
      } else {
        add(AuthLogoutEvent());
      }
    });
    on<AuthEvent>((_, emit) => emit(AuthInitial()));
    on<AuthLoginEvent>(_authed);
    on<AuthLogoutEvent>((_, emit) => emit(AuthFailureState()));
  }

  void _authed(AuthLoginEvent event, Emitter emit) {
    emit(AuthSuccessState(user: event.user));
  }

  @override
  Future<void> close() async {
    super.close();

    await _subscription.cancel();
  }
}
