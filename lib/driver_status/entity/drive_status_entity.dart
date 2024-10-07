class DriverStatusEntity {
  final int isActive;

  DriverStatusEntity({required this.isActive});

  // Factory method to create an instance from JSON
  factory DriverStatusEntity.fromJson(Map<String, dynamic> json) {
    return DriverStatusEntity(
      isActive: json['is_active'], // Extracting the 'is_active' field
    );
  }

  // Method to convert the instance back to JSON
  Map<String, dynamic> toJson() {
    return {
      'is_active': isActive,
    };
  }
}
