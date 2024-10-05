import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics/data/prefs/prefs.dart';
import 'package:logistics/profile/entity/profile_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

final profileProvider = FutureProvider<ProfileEntity?>((ref) async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  final preHelper = PrefsHelper(sp);
  print(
      'i am in profile provider this is data: ${preHelper.getProfileEntity()!.name}');
  return preHelper.getProfileEntity();
});

final passwordProfileProvider = FutureProvider<String?>((ref) async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  final preHelper = PrefsHelper(sp);
  ProfileEntity? profile = preHelper.getProfileEntity();
  var pass = '${profile!.password}';
  return pass;
});
final userNameProvider = StateProvider<String>((ref) {
  return 'name';
});
