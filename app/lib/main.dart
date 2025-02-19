import 'package:app/src/LoanDetails/loan_details_provider.dart';
import 'package:app/src/LoanTree/loan_details_provider.dart';
import 'package:app/src/scanner/scanner_provider.dart';
import 'package:app/src/security/authentication_middleware.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/login/auth_provider.dart';
import 'src/app_router.dart';

void main() {
  // Create a single instance of AuthenticatedDioClient.
  final authDioClient = AuthenticatedDioClient();

  // Inject the Dio client into your AuthProvider.
  final authProvider = AuthProvider(authenticatedDioClient: authDioClient);

  runApp(
    MultiProvider(
      providers: [
        // Provide the Dio client instance if needed elsewhere.
        Provider<AuthenticatedDioClient>.value(value: authDioClient),
        ChangeNotifierProvider<AuthProvider>.value(value: authProvider),
        ChangeNotifierProvider(create: (context) => LoanTreeProvider()),
        ChangeNotifierProvider(create: (context) => ScannerProvider()),
        ChangeNotifierProvider(create: (context) => LoanDetailsProvider()),
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
