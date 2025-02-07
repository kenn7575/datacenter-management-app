import 'package:app/src/LoanDetails/loan_details_page.dart';
import 'package:app/src/main_route_layout.dart';
import 'package:app/src/scanner/qr_scanner_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'login/auth_provider.dart';
import 'login/login_page.dart';

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
      ShellRoute(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => QrScannerPage(),
          ),
          GoRoute(
            path: '/scanner',
            builder: (context, state) => Text("Scanner"),
          ),
          GoRoute(
              path: "/scanner/:loanId",
              builder: (context, state) {
                //TODO: Handle null
                final loanId = state.pathParameters['loanId']!;
                return LoanDetailsPage(
                  loanId: loanId,
                );
              }),
        ],
        builder: (context, state, child) {
          return MainRouteLayout(
            child: child,
          );
        },
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginPage(),
      ),
    ],
  );
}
