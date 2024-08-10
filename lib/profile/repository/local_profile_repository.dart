import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics/constants/images.dart';
import 'package:logistics/profile/entity/profile_entity.dart';
import 'package:logistics/profile/repository/profile_repository.dart';

final localProfileRepository = StateProvider((ref) => LocalProfileRepository());

class LocalProfileRepository implements ProfileRepository {
  @override
  ProfileEntity getProfile() {
    return ProfileEntity(
      token: '123',
      name: "Amal",
      phone: "0507126387",
      password: "12345",
      gender: "Female",
      birthDate: "01/01/1997",
      email: 'amail@gmail.com',
      country: 'Saudi Arabia',
      imageProfile: ImageAssets.profile,
    );
  }
}
