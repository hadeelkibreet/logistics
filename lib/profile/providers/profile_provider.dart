import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics/profile/repository/local_profile_repository.dart';

final profileProvider = FutureProvider(
  (ref) => ref.read(localProfileRepository).getProfile(),
);
final userNameProvider = StateProvider<String>((ref) {
  return 'name';
});
