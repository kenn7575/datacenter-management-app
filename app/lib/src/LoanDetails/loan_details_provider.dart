import 'package:app/src/utils/constants.dart';
import 'package:app/src/utils/errors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LoanDetailsProvider extends ChangeNotifier {
  bool? loanDetails;
  Failure? failure;

  Future<void> getSpecificLoan(int id) async {
    final dio = Dio();

    try {
      dio.options = BaseOptions(
        sendTimeout: Duration(seconds: 10),
      );
      Response response =
          await dio.get("$kBackendUrl/api/Loans/GetLoanById?loanId=$id");
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        failure = ValidationFailure(
            statusCode: 400,
            errorMessage: 'Invalid input',
            fieldError: e.response?.data);
      }
      if (e.response?.statusCode == 404) {
        failure = ServerFailure(
            statusCode: 404, errorMessage: 'Loan with id $id not found');
      }
      failure = ServerFailure(
          errorMessage: 'An error occurred',
          statusCode: e.response?.statusCode);
    } catch (e) {
      failure = ServerFailure(
        errorMessage: 'An error occurred',
      );
    }

    notifyListeners();
  }

  void logout() {
    notifyListeners();
  }
}
