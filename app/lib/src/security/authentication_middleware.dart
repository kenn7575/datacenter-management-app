import 'package:app/src/security/check_token_validity.dart';
import 'package:app/src/security/token_local_data_source.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthenticatedDioClient {
  static final AuthenticatedDioClient _instance =
      AuthenticatedDioClient._internal();
  final Dio client = Dio();
  final ValueNotifier<bool> isAuthenticated = ValueNotifier(false);

  factory AuthenticatedDioClient() {
    return _instance;
  }

  AuthenticatedDioClient._internal() {
    client.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Get the current access token
          String? accessToken = await getAccessToken();

          // Check if the access token is expired
          bool isTokenValid = await checkTokenValidity();
          if (isTokenValid) {
            // Update access token
            isAuthenticated.value = true;
          } else {
            isAuthenticated.value = false;
            handler.reject(DioException(
              requestOptions: options,
              error: 'Unable to refresh access token. Please login again.',
            ));
            return;
          }
          // Add the authorization header with the access token
          options.headers['Authorization'] = 'Bearer $accessToken';
          handler.next(options);
        },
      ),
    );
  }
}
