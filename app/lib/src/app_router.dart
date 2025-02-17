import 'package:app/src/LoanTree/loan_details_page.dart';
import 'package:app/src/login/login_page.dart';
import 'package:app/src/main_route_layout.dart';
import 'package:app/src/scanner/qr_scanner_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'login/auth_provider.dart';

class AppRouter {
  static GoRouter getRouter(AuthProvider authProvider) {
    return GoRouter(
      initialLocation: "/login",
      refreshListenable: authProvider, // Use the same instance
      redirect: (context, state) {
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
              path: "/loans/:loanId",
              builder: (context, state) {
                final loanId = state.pathParameters['loanId']!;
                return LoanTreePage(
                  loanId: loanId,
                );
              },
            ),
            GoRoute(
              path: "/loans/:loanId/details",
              builder: (context, state) {
                final loanId = state.pathParameters['loanId']!;
                return Scaffold(
                  appBar: AppBar(
                    title: Text("Loan $loanId Details"),
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        context.pop();
                      },
                    ),
                  ),
                  body: Center(
                    child: Text("Details for loan $loanId"),
                  ),
                );
              },
            ),
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
}
