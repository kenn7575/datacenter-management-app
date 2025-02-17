class LoanModel {
  final int id;
  final String loanerId;
  final int itemId;
  final String name;
  final String returnedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? leaseEndDate;
  final String? status;
  final int? location;

  LoanModel({
    required this.id,
    required this.loanerId,
    required this.itemId,
    required this.name,
    required this.returnedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.leaseEndDate,
    required this.status,
    this.location,
  });

  factory LoanModel.fromJson(Map<String, dynamic> json) {
    return LoanModel(
      id: json['id'],
      loanerId: json['loanerId'],
      itemId: json['itemId'],
      name: json['name'],
      returnedAt: json['returnedAt'],
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
