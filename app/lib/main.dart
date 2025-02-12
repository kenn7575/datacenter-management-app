import 'package:app/src/LoanDetails/loan_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/login/auth_provider.dart';
import 'src/app_router.dart';

void main() {
  final authProvider = AuthProvider();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => authProvider),
        ChangeNotifierProvider(create: (context) => LoanDetailsProvider())
      ],
      child: MyApp(authProvider: authProvider),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AuthProvider authProvider;

  const MyApp({super.key, required this.authProvider});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter App',
      routerConfig: AppRouter.getRouter(authProvider),
    );
  }
}
