import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/login/auth_provider.dart';
import 'src/app_router.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter App',
      routerConfig: AppRouter.router,
    );
  }
}