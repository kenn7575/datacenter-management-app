class LoanDetailsModel {
  final String token;

  LoanDetailsModel({required this.token});

  factory LoanDetailsModel.fromJson({required Map<String, dynamic> json}) {
    return LoanDetailsModel(token: json["token"]);
  }
}
