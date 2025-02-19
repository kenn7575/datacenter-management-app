import 'package:app/src/LoanTree/loan_item_model.dart';
import 'package:app/src/security/authentication_middleware.dart';
import 'package:app/src/utils/constants.dart';
import 'package:app/src/utils/errors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LoanTreeProvider extends ChangeNotifier {
  ItemTreeModel? loanItems;
  Failure? failure;

  Future<void> fetchLoanItems(int id) async {
    final authenticatedDioClient = AuthenticatedDioClient();

    try {
      authenticatedDioClient.client.options = BaseOptions(
        sendTimeout: Duration(seconds: 10),
      );
      Response response = await authenticatedDioClient.client
          .get("$kBackendUrl/api/Items/GetItemsInLoan?loanId=$id");

      ItemTreeModel itemModel = ItemTreeModel.fromJson(response.data);
      loanItems = itemModel;
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

  void logout() {
    notifyListeners();
  }
}
