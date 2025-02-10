import 'package:app/src/login/token_model.dart';
import 'package:app/src/utils/constants.dart';
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
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      sendTimeout: Duration(seconds: 10),
    );

    try {
      print("Attempting login request...");
      Response response = await dio.post(
        "$kBackendUrl/api/Account/login",
        data: {"username": username, "password": password},
      );

      print("Response received!");
      print("Status Code: ${response.statusCode}");
      print("Response Data: ${response.data}");

      TokenModel token = TokenModel.FromJson(json: response.data);

      final storage = FlutterSecureStorage();
      await storage.write(key: "RefreshToken", value: token.token);

      _isAuthenticated = true;
      notifyListeners();
    } on DioException catch (dioError) {
      print("Dio error occurred: ${dioError.message}");
      if (dioError.response != null) {
        print("Response status: ${dioError.response?.statusCode}");
        print("Response data: ${dioError.response?.data}");
      } else {
        print("Dio request failed before response was received");
      }
    } catch (e, stackTrace) {
      print("Unexpected error: $e");
      print("Stack trace: $stackTrace");
    }
  }

  void logout() {
    _isAuthenticated = false;
    notifyListeners();
  }
}
