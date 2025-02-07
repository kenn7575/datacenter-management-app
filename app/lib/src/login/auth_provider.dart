import 'package:app/src/login/token_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  void login(String username, String password) async {
    // Fake login logic
    final dio = Dio();
    dio.options = BaseOptions(
        sendTimeout: Duration(seconds: 10),
        validateStatus: (code) {
          return true;
        });
    Response response = await dio.post(
        "http://192.168.1.151:5001/api/Account/login",
        data: {"username": username, "password": password});

    TokenModel token = TokenModel.FromJson(json: response.data);

    final storage = FlutterSecureStorage();
    await storage.write(key: "RefreshToken", value: token.token);

    _isAuthenticated = true;
    notifyListeners();
  }

  void logout() {
    _isAuthenticated = false;
    notifyListeners();
  }
}
