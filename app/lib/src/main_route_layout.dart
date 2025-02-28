import 'package:app/src/login/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MainRouteLayout extends StatefulWidget {
  const MainRouteLayout({super.key, required this.child});

  final Widget child;

  @override
  State<MainRouteLayout> createState() => _MainRouteLayoutState();
}

class _MainRouteLayoutState extends State<MainRouteLayout> {
  Widget get child => widget.child;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: true);

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Sign out',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            context.go("/");
          }
          if (index == 1) {
            print("Logout");
            authProvider.logout();
          }
        },
      ),
      body: child,
    );
  }
}
