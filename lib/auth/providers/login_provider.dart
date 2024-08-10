import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics/auth/repository/local_login_repositry.dart';
import 'package:shared_preferences/shared_preferences.dart';

final LoginProvider = FutureProvider(
  (ref) => ref.read(localLoginRepositry).setLogin(),
);

final isLoggedInProvider = StateProvider<bool>((ref) => false);

final saveUserl = FutureProvider((ref) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //bool isLoggedIn = true;
  await prefs.setBool('isLoggedIn', ref.watch(isLoggedInProvider));
});
