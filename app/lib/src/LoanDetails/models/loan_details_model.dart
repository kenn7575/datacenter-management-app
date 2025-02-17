import 'package:app/src/LoanDetails/models/item_model.dart';
import 'package:app/src/LoanDetails/models/loan_model.dart';

class LoanDetailsModel {
  final LoanModel loanModel;
  final ItemModel itemModel;

  LoanDetailsModel({
    required this.loanModel,
    required this.itemModel,
  });

  factory LoanDetailsModel.fromJson(Map<String, dynamic> json) {
    return LoanDetailsModel(
      loanModel: LoanModel.fromJson(json['loan']),
      itemModel: ItemModel.fromJson(json['item']),
    );
  }

  /// **Method for serializing to JSON**
  Map<String, dynamic> toJson() {
    return {
      'loan': loanModel.toJson(),
      'item': itemModel.toJson(),
    };
  }
}
