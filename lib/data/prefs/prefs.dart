import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:logistics/data/prefs/PreferencesKeys.dart';
import 'package:logistics/data/prefs/shared_pref_provider.dart';
import 'package:logistics/profile/entity/profile_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../auth/entity/login_entity.dart';

final prefHelperProvider = Provider((ref) {
  return PrefsHelper(ref.read(sharedPrefProvider).requireValue);
});

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

  // Save ProfileEntity
  Future<void> saveProfileEntity(ProfileEntity entity) async {
    String jsonString = jsonEncode(entity.toJson());
    await prefs.setString('profile_entity', jsonString);
  }

  // Retrieve ProfileEntity
  ProfileEntity? getProfileEntity() {
    String? jsonString = prefs.getString('profile_entity');
    if (jsonString != null) {
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return ProfileEntity.fromJson(jsonMap);
    }
    return null;
  }

  ProfileEntity get userInfo {
    return ProfileEntity(
        id: prefs.getInt(PreferencesKeys.USER_ID) ?? 0,
        nationalityId:
            prefs.getString(PreferencesKeys.USER_nationality_id) ?? '',
        supervisorId: prefs.getString(PreferencesKeys.USER_supervisor_id) ?? '',
        gender: prefs.getString(PreferencesKeys.USER_GENDER) ?? '',
        image: prefs.getString(PreferencesKeys.USER_IMAGE) ?? '',
        userName: prefs.getString(PreferencesKeys.USER_USER_NAME) ?? '',
        name: prefs.getString(PreferencesKeys.USER_NAME) ?? '',
        password: prefs.getString(PreferencesKeys.USER_PASSWORD) ?? '',
        email: prefs.getString(PreferencesKeys.USER_EMAIL) ?? '',
        phone: prefs.getString(PreferencesKeys.USER_PHONE) ?? '',
        address: prefs.getString(PreferencesKeys.USER_address) ?? '',
        isActive: prefs.getString(PreferencesKeys.USER_is_active) ?? '0',
        createdAt: prefs.getString(PreferencesKeys.USER_created_at) ?? '',
        carId: prefs.getString(PreferencesKeys.USER_car_id) ?? '',
        token: prefs.getString(PreferencesKeys.USER_TOKEN) ?? '',
        code: prefs.getString(PreferencesKeys.USER_CODE) ?? "",
        updatedAt: prefs.getString(PreferencesKeys.USER_updated_at) ?? '');
  }

  setLoggedIn() {
    prefs.setBool(PreferencesKeys.IS_LOGGED_IN, true);
  }

  Future<void> saveUserInfo(ProfileEntity user,
      {required bool isLoggedIn}) async {
    print("----> saved ${user.toString()}");

    prefs.setInt(PreferencesKeys.USER_ID, user.id);
    prefs.setString(PreferencesKeys.USER_nationality_id, user.nationalityId);
    prefs.setString(PreferencesKeys.USER_supervisor_id, user.supervisorId);
    prefs.setString(PreferencesKeys.USER_GENDER, user.gender);
    prefs.setString(PreferencesKeys.USER_IMAGE, user.image);
    prefs.setString(PreferencesKeys.USER_USER_NAME, user.userName);
    prefs.setString(PreferencesKeys.USER_NAME, user.name);
    prefs.setString(PreferencesKeys.USER_PASSWORD, user.password);
    prefs.setString(PreferencesKeys.USER_EMAIL, user.email);
    prefs.setString(PreferencesKeys.USER_PHONE, user.phone);
    prefs.setString(PreferencesKeys.USER_address, user.address);
    prefs.setString(PreferencesKeys.USER_is_active, user.isActive);
    prefs.setString(PreferencesKeys.USER_created_at, user.createdAt);
    prefs.setString(PreferencesKeys.USER_car_id, user.carId);
    prefs.setString(PreferencesKeys.USER_TOKEN, user.token);
    prefs.setString(PreferencesKeys.USER_CODE, user.code);
    prefs.setString(PreferencesKeys.USER_updated_at, user.updatedAt);
    return Future.value();
  }

  Future<void> clearUserInfo() async {
    prefs.clear();
    return Future.value();
  }
}
