import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'login/auth_provider.dart';
import 'login/login_page.dart';
// import '../screens/home_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: "/login",
    redirect: (context, state) {
      final authProvider = Provider.of<AuthProvider>(context, listen: true);
      bool isAuthenticated = authProvider.isAuthenticated;

      if (!isAuthenticated && state.fullPath != '/login') {
        return '/login';
      }
      if (isAuthenticated && state.fullPath == '/login') {
        return '/';
      }
      return null; // No redirection
    },
    routes: [
      // GoRoute(
      //   path: '/',
      //   builder: (context, state) => HomePage(),
      // ),
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginPage(),
      ),
    ],
  );
}
