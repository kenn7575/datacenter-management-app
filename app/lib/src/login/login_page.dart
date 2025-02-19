import 'package:app/src/login/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginFrom(),
    );
  }
}

class LoginFrom extends StatefulWidget {
  const LoginFrom({super.key});

  @override
  State<LoginFrom> createState() => _LoginFromState();
}

class _LoginFromState extends State<LoginFrom> {
  String username = "";
  String password = "";

  @override
  void initState() {
    bool NO = false;
    super.initState();
    Provider.of<AuthProvider>(context, listen: NO).CheckForValidToken();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text.rich(
            TextSpan(
                text: Provider.of<AuthProvider>(context).errorMessage,
                style: TextStyle(color: Color.fromARGB(0, 255, 0, 0))),
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Username",
            ),
            onChanged: (value) => {username = value},
          ),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Password",
            ),
            onChanged: (value) => {password = value},
          ),
          ElevatedButton(
            onPressed: () => {
              Provider.of<AuthProvider>(context, listen: false)
                  .login(username, password)
            },
            child: Text("Login"),
          ),
          ElevatedButton(
            onPressed: () => {
              Provider.of<AuthProvider>(context, listen: false)
                  .login("jeff", "Ab_123456789")
            },
            child: Text("Instant Login(Debug)"),
          )
        ],
      ),
    );
  }
}
