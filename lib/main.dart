import 'package:certispec/firebase_options.dart';
import 'package:certispec/pages/auth/bloc/auth_bloc.dart';
import 'package:certispec/pages/customers/bloc/customer_bloc.dart';
import 'package:certispec/pages/tests/bloc/test_bloc.dart';
import 'package:certispec/services/router/app_router.dart';
import 'package:certispec/services/singleton/singleton_service.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart'
    show Firebase, FirebaseException;
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await initSingleton();
    runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => singleton<AuthBloc>()),
          BlocProvider(create: (context) => singleton<TestBloc>()),
          BlocProvider(create: (context) => singleton<CustomerBloc>()),
        ],
        child: const MyApp(),
      ),
    );
  } on FirebaseException catch (e) {
    // If Firebase isn't configured yet (no google-services.json / plist),
    // initialization will fail here. That's okay during setup — follow
    // the README steps to add platform files or run `flutterfire configure`.
    // We print the error to help debugging.
    // ignore: avoid_print
    print('Firebase.initializeApp error: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'CertiSpec Laboratory',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(colorScheme: ColorScheme(brightness: Brightness.light, primary: Colors.black, onPrimary: onPrimary, secondary: secondary, onSecondary: onSecondary, error: error, onError: onError, surface: surface, onSurface: onSurface).fromSeed(seedColor: Colors.deepPurple)),
      routerConfig: AppRouter.router(),
    );
  }
}
