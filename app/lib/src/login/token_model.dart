class TokenModel {
  final String token;

  TokenModel({required this.token});

  factory TokenModel.FromJson({required Map<String, dynamic> json}) {
    return TokenModel(token: json["token"]);
  }
}
