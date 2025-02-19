class LoanModel {
  final int id;
  final String loanerId;
  final int itemId;
  final String name;
  final int status;
  final int location;
  final DateTime? returnedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? leaseEndDate;

  LoanModel({
    required this.id,
    required this.loanerId,
    required this.itemId,
    required this.name,
    required this.status,
    required this.location,
    this.returnedAt,
    this.createdAt,
    this.updatedAt,
    this.leaseEndDate,
  });

  factory LoanModel.fromJson(Map<String, dynamic> json) {
    return LoanModel(
      id: json['id'],
      loanerId: json['loanerId'],
      itemId: json['itemId'],
      name: json['name'],
      returnedAt: DateTime.parse(json['returnedAt']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      leaseEndDate: DateTime.parse(json['leaseEndDate']),
      status: json['status'],
      location: json['location'],
    );
  }

  /// **Method for serializing to JSON**
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'loanerId': loanerId,
      'itemId': itemId,
      'name': name,
      'returnedAt': returnedAt,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'leaseEndDate': leaseEndDate?.toIso8601String(),
      'status': status,
      'location': location,
    };
  }
}
