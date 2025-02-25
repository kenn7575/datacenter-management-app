import 'package:app/src/LoanDetails/models/loan_details_model.dart';
import 'package:app/src/security/authentication_middleware.dart';
import 'package:app/src/utils/constants.dart';
import 'package:app/src/utils/errors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LoanDetailsProvider extends ChangeNotifier {
  LoanDetailsModel? loanDetailsModel;
  Failure? failure;

  Future<void> fetchLoanDetails(int id) async {
    final authenticatedDioClient = AuthenticatedDioClient();
    try {
      authenticatedDioClient.client.options = BaseOptions(
        sendTimeout: Duration(seconds: 10),
      );

      Response response = await authenticatedDioClient.client
          .get("$kBackendUrl/api/Loans/GetLoanByItemId?itemId=$id");

      LoanDetailsModel ldm = LoanDetailsModel.fromJson(response.data);
      loanDetailsModel = ldm;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        failure = ValidationFailure(
            statusCode: 400,
            errorMessage: 'Invalid input',
            fieldError: e.response?.data?["title"]);
      } else if (e.response?.statusCode == 404) {
        failure = ServerFailure(
            statusCode: 404, errorMessage: 'Loan with id $id not found');
      } else {
        failure = ServerFailure(
            errorMessage: 'An error occurred',
            statusCode: e.response?.statusCode ?? 500);
      }
    } catch (e) {
      failure = ServerFailure(
        errorMessage: 'An error occurred',
      );
    }

    notifyListeners();
  }

  Future<void> returnLoan(int id) async {
    final authenticatedDioClient = AuthenticatedDioClient();
    try {
      Response response = await authenticatedDioClient.client
          .put("$kBackendUrl/api/Loans/ChangeLoanStatus?id=$id", data: '"Inactive"');

      if (response.statusCode == 200) {
        await fetchLoanDetails(id);
      } else {
        print('Failed to return loan: ${response.data}');
        failure = ServerFailure(
            errorMessage: 'Failed to return loan',
            statusCode: response.statusCode ?? 500);
      }
    } on DioException catch (e) {
      print('DioException: ${e.response?.data}');
      failure = ServerFailure(
          errorMessage: 'An error occurred',
          statusCode: e.response?.statusCode ?? 500);
    } catch (e) {
      print('Exception: $e');
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
