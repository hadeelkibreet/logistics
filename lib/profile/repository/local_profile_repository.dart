import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics/profile/entity/profile_entity.dart';
import 'package:logistics/profile/repository/profile_repository.dart';

final localProfileRepository = StateProvider((ref) => LocalProfileRepository());

class LocalProfileRepository implements ProfileRepository {
  @override
  ProfileEntity getProfile() {
    throw UnimplementedError();
  }
}
