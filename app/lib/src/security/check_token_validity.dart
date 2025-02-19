import 'package:app/src/security/token_local_data_source.dart';
import 'package:app/src/utils/constants.dart';
import 'package:app/src/utils/errors.dart';
import 'package:dio/dio.dart';

final dio = Dio();

Future<bool> checkTokenValidity() async {
  try {
    final refreshToken = await getAccessToken();
    if (refreshToken == null) return false;

    final response = await dio.post(
      '$kBackendUrl/api/Account/ValidateToken',
      data: {'Token': refreshToken},
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      await deleteAccessToken();
      return false;
    }
  } on DioException catch (e) {
    if (e.response != null) {
      throw ServerFailure(
          errorMessage: e.response?.data?['message'] ?? "",
          statusCode: e.response?.statusCode);
    } else {
      await deleteAccessToken();
      return false;
    }
  } catch (e) {
    await deleteAccessToken();
    return false;
  }
}
