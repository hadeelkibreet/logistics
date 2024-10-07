class DriverStatusEntity {
  final int isActive;

  DriverStatusEntity({required this.isActive});

  factory DriverStatusEntity.fromJson(Map<String, dynamic> json) {
    return DriverStatusEntity(
      isActive: json['is_active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'is_active': isActive,
    };
  }
}
