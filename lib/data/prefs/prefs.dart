import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:logistics/data/prefs/PreferencesKeys.dart';
import 'package:logistics/profile/entity/profile_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../auth/entity/login_entity.dart';

@LazySingleton()
class PrefsHelper {
  final SharedPreferences prefs;

  PrefsHelper(this.prefs);

  bool get getIsLoggedIn =>
      prefs.getBool(PreferencesKeys.IS_LOGGED_IN) ?? false;

  String get getUserToken => prefs.getString(PreferencesKeys.USER_TOKEN) ?? '';

  Future<void> setUserToken(String token) async {
    await prefs.setString(PreferencesKeys.USER_TOKEN, token);
  }

  // Save LoginEntity
  Future<void> saveLoginEntity(LoginEntity entity) async {
    String jsonString = jsonEncode(entity.toJson());
    await prefs.setString('login_entity', jsonString);
  }

  // Retrieve LoginEntity
  LoginEntity? getLoginEntity() {
    String? jsonString = prefs.getString('login_entity');
    if (jsonString != null) {
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return LoginEntity.fromJson(jsonMap);
    }
    return null;
  }

  ProfileEntity get userInfo {
    return ProfileEntity(
        token: prefs.getString(PreferencesKeys.USER_TOKEN) ?? '',
        name: prefs.getString(PreferencesKeys.USER_NAME) ?? '',
        phone: prefs.getString(PreferencesKeys.USER_PHONE) ?? '',
        password: prefs.getString(PreferencesKeys.USER_PASSWORD) ?? '',
        gender: prefs.getString(PreferencesKeys.USER_GENDER) ?? '',
        birthDate: prefs.getString(PreferencesKeys.USER_BIRTHDATE) ?? '',
        email: prefs.getString(PreferencesKeys.USER_EMAIL) ?? '',
        country: prefs.getString(PreferencesKeys.USER_COUNTRY) ?? '',
        imageProfile: prefs.getString(PreferencesKeys.USER_IMAGEPROFILE) ?? '');
  }

  setLoggedIn() {
    prefs.setBool(PreferencesKeys.IS_LOGGED_IN, true);
  }

  Future<void> saveUserInfo(ProfileEntity user,
      {required bool isLoggedIn}) async {
    print("----> saved ${user.toString()}");
    prefs.setString(PreferencesKeys.USER_EMAIL, user.email);
    prefs.setString(PreferencesKeys.USER_TOKEN, user.token);
    prefs.setBool(PreferencesKeys.IS_LOGGED_IN, isLoggedIn);
    prefs.setString(PreferencesKeys.USER_PASSWORD, user.password);
    prefs.setString(PreferencesKeys.USER_NAME, user.name);
    prefs.setString(PreferencesKeys.USER_PHONE, user.phone);
    prefs.setString(PreferencesKeys.USER_GENDER, user.gender);
    prefs.setString(PreferencesKeys.USER_BIRTHDATE, user.birthDate);
    prefs.setString(PreferencesKeys.USER_IMAGEPROFILE, user.imageProfile);
    prefs.setString(PreferencesKeys.USER_COUNTRY, user.country);

    return Future.value();
  }

  Future<void> clearUserInfo() async {
    prefs.clear();
    return Future.value();
  }
}
