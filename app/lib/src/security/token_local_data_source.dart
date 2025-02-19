import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();
//TODO: replace logic that uses flutter_secure_storage directly with the following code
// Access token
Future<void> saveAccessTokens(String accessToken) async {
  await storage.write(key: 'AccessToken', value: accessToken);
}

Future<String?> getAccessToken() async =>
    await storage.read(key: 'AccessToken');

Future<void> deleteAccessToken() async {
  await storage.delete(key: 'AccessToken');
}
