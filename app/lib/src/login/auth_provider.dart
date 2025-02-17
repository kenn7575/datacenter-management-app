import 'dart:convert';
import 'package:app/src/login/token_model.dart';
import 'package:app/src/utils/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  String _errorMessage = "";

  bool get isAuthenticated => _isAuthenticated;
  String get errorMessage => _errorMessage;

  Future<void> login(String username, String password) async {
    // Fake login logic
    final dio = Dio();
    dio.options = BaseOptions(
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      sendTimeout: Duration(seconds: 10),
    );

    try {
      //send login request
      Response response = await dio.post(
        "$kBackendUrl/api/Account/login",
        data: {"username": username, "password": password},
      );
      TokenModel token = TokenModel.FromJson(json: response.data);

      //store access token
      final storage = FlutterSecureStorage();
      await storage.write(key: "AccessToken", value: token.token);

      //update auth state
      _isAuthenticated = true;
      notifyListeners();
    } on DioException catch (dioError) {
      print("Dio error occurred: ${dioError.message}");
      if (dioError.response != null) {
        if (dioError.response?.statusCode == 401) {
          _errorMessage = jsonDecode(dioError.response?.data);
        }
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

    //clear access token
    final storage = FlutterSecureStorage();
    storage.delete(key: "AccessToken");

    notifyListeners();
  }

  void CheckForValidToken() async {
    try {
      final dio = Dio();
      final storage = FlutterSecureStorage();

      String? token = await storage.read(key: "AccessToken");

      Response response = await dio.post(
          "$kBackendUrl/api/Account/RefreshToken",
          data: {"Token": token});

      TokenModel tokenM = TokenModel.FromJson(json: response.data);

      await storage.write(key: "AccessToken", value: tokenM.token);

      _isAuthenticated = true;
    } catch (e) {
      _isAuthenticated = false;
    }
  }
}
