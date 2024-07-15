import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics/home/profile/entity/profile_entity.dart';
import 'package:logistics/home/profile/repository/profile_repository.dart';

final localProfileRepository = StateProvider((ref) => LocalProfileRepository());

class LocalProfileRepository implements ProfileRepository {
  @override
  ProfileEntity getProfile() {
    return ProfileEntity(
      name: "Amal",
      phone: "0507126387",
      password: "12345",
      gender: "Female",
      birthDate: "01/01/1997",
    );
  }
}
