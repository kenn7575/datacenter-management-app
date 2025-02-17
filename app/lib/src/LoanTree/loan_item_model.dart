class ItemTreeModel {
  final int id;
  final int? parentId;
  final String owner;
  final String name;
  final String os;
  final int status;
  final DateTime retirement;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? description;
  final List<ItemTreeModel> childData;

  ItemTreeModel({
    required this.id,
    required this.owner,
    required this.name,
    required this.os,
    required this.status,
    required this.retirement,
    required this.createdAt,
    required this.updatedAt,
    this.parentId,
    this.description,
    this.childData = const <ItemTreeModel>[],
  });

  factory ItemTreeModel.fromJson(Map<String, dynamic> json) {
    return ItemTreeModel(
      id: json['id'],
      parentId: json['parentId'],
      owner: json['owner'],
      name: json['name'],
      os: json['os'],
      status: json['status'],
      retirement: DateTime.parse(json['retirement']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      description: json['description'],
      childData: (json['childData'] as List<dynamic>?)
              ?.map((e) => ItemTreeModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  /// **Method for serializing to JSON**
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parentId': parentId,
      'owner': owner,
      'name': name,
      'os': os,
      'status': status,
      'retirement': retirement.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'description': description,
      'childData': childData.map((e) => e.toJson()).toList(),
    };
  }
}
