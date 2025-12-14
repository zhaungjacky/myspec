import 'package:certispec/pages/auth/auth_gate.dart';
import 'package:certispec/pages/customers/customer_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter router() => GoRouter(
    initialLocation: AuthGate.routhPath(),
    routes: [
      GoRoute(
        path: AuthGate.routhPath(),
        builder: (context, state) => const AuthGate(),
        // path: AuthGate.route(),
        // builder: (context, state) => const AuthGate(),
      ),
      GoRoute(
        path: CustomerPage.routhPath(),
        builder: (context, state) => const CustomerPage(),
        // path: AuthGate.route(),
        // builder: (context, state) => const AuthGate(),
      ),
    ],
  );
}
