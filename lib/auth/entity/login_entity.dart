class LoginEntity {
  final String accessToken;
  final String tokenType;
  final String flag;
  final User user;
  final List<dynamic> currentRequests;
  final int nbNotifs;

  LoginEntity({
    required this.accessToken,
    required this.tokenType,
    required this.flag,
    required this.user,
    required this.currentRequests,
    required this.nbNotifs,
  });

  factory LoginEntity.fromJson(Map<String, dynamic> json) {
    return LoginEntity(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      flag: json['flag'],
      user: User.fromJson(json['user']),
      currentRequests: json['current_requests'] ?? [],
      nbNotifs: json['nb_notifs'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'token_type': tokenType,
      'flag': flag,
      'user': user.toJson(),
      'current_requests': currentRequests,
      'nb_notifs': nbNotifs,
    };
  }
}

class User {
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
  final String isActive;
  final DateTime createdAt;
  final String carId;
  final String token;
  final String? fcmToken;
  final String code;
  final DateTime updatedAt;
  final List<City> cities;

  User({
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
    required this.fcmToken,
    required this.code,
    required this.updatedAt,
    required this.cities,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
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
      createdAt: DateTime.parse(json['created_at']),
      carId: json['car_id'],
      token: json['token'],
      fcmToken: json['fcm_token'],
      code: json['code'],
      updatedAt: DateTime.parse(json['updated_at']),
      cities: (json['cities'] as List).map((i) => City.fromJson(i)).toList(),
    );
  }

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
      'created_at': createdAt.toIso8601String(),
      'car_id': carId,
      'token': token,
      'fcm_token': fcmToken,
      'code': code,
      'updated_at': updatedAt.toIso8601String(),
      'cities': cities.map((city) => city.toJson()).toList(),
    };
  }
}

class City {
  final String cityId;
  final int id;
  final String name;
  final String isActive;
  final dynamic createdAt;
  final dynamic updatedAt;
  final Pivot pivot;

  City({
    required this.cityId,
    required this.id,
    required this.name,
    required this.isActive,
    this.createdAt,
    this.updatedAt,
    required this.pivot,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      cityId: json['city_id'],
      id: json['id'],
      name: json['name'],
      isActive: json['is_active'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      pivot: Pivot.fromJson(json['pivot']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city_id': cityId,
      'id': id,
      'name': name,
      'is_active': isActive,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'pivot': pivot.toJson(),
    };
  }
}

class Pivot {
  final String driverId;
  final String citieId;

  Pivot({
    required this.driverId,
    required this.citieId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      driverId: json['driver_id'],
      citieId: json['citie_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'driver_id': driverId,
      'citie_id': citieId,
    };
  }
}
