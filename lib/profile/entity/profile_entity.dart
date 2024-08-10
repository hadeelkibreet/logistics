class ProfileEntity {
  final String token;
  final String name;
  final String phone;
  final String password;
  final String gender;
  final String birthDate;
  final String email;
  final String country;
  final String imageProfile;
  ProfileEntity({
    required this.token,
    required this.name,
    required this.phone,
    required this.password,
    required this.gender,
    required this.birthDate,
    required this.email,
    required this.country,
    required this.imageProfile,
  });
  factory ProfileEntity.fromJson(Map<String, dynamic> json) {
    return ProfileEntity(
        token: json["token"],
        name: json["name"],
        phone: json["phone"],
        password: json["password"],
        gender: json["gender"],
        birthDate: json["birthDate"],
        email: json["email"],
        country: json["country"],
        imageProfile: json["imageProfile"]);
  }
}
