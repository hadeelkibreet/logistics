class ProfileEntity {
  final int id;
  final String nationalityId;
  final String supervisorId;
  final String gender;
  final String image;
  final String userName;
  final String name;
  final String password;
  final String email;
  final String phone;
  final String address;
  final int isActive;
  final String createdAt;
  final int carId;
  final String token;
  final String? fcmToken; // Nullable field
  final int code;
  final String updatedAt;

  // Constructor
  ProfileEntity({
    required this.id,
    required this.nationalityId,
    required this.supervisorId,
    required this.gender,
    required this.image,
    required this.userName,
    required this.name,
    required this.password,
    required this.email,
    required this.phone,
    required this.address,
    required this.isActive,
    required this.createdAt,
    required this.carId,
    required this.token,
    this.fcmToken,
    required this.code,
    required this.updatedAt,
  });

  // Factory constructor for creating a User instance from JSON
  factory ProfileEntity.fromJson(Map<String, dynamic> json) {
    return ProfileEntity(
      id: json['id'],
      nationalityId: json['nationality_id'],
      supervisorId: json['supervisor_id'],
      gender: json['gender'],
      image: json['image'],
      userName: json['user_name'],
      name: json['name'],
      password: json['password'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      isActive: json['is_active'],
      createdAt: json['created_at'],
      carId: json['car_id'],
      token: json['token'],
      fcmToken: json['fcm_token'], // Could be null
      code: json['code'],
      updatedAt: json['updated_at'],
    );
  }

  // Method for converting a User instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nationality_id': nationalityId,
      'supervisor_id': supervisorId,
      'gender': gender,
      'image': image,
      'user_name': userName,
      'name': name,
      'password': password,
      'email': email,
      'phone': phone,
      'address': address,
      'is_active': isActive,
      'created_at': createdAt,
      'car_id': carId,
      'token': token,
      'fcm_token': fcmToken,
      'code': code,
      'updated_at': updatedAt,
    };
  }
}
