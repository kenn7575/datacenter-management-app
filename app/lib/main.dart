import 'package:app/src/LoanDetails/loan_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/login/auth_provider.dart';
import 'src/app_router.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => LoanDetailsProvider())
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter App',
      routerConfig: AppRouter.router,
    );
  }
}
