class ReasonsRejectionStatusEntity {
  int id;
  String name;

  ReasonsRejectionStatusEntity({required this.id, required this.name});

  factory ReasonsRejectionStatusEntity.fromJson(Map<String, dynamic> json) {
    return ReasonsRejectionStatusEntity(
      id: json['id'],
      name: json['name'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
