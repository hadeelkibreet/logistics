import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics/home/profile/entity/profile_entity.dart';
import 'package:logistics/home/profile/repository/profile_repository.dart';

final remoteProfileRepository =
    StateProvider((ref) => RemoteProfileRepository());

class RemoteProfileRepository implements ProfileRepository {
  @override
  ProfileEntity getProfile() {
    throw UnimplementedError();
  }
}
