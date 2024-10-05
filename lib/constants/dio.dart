import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logistics/data/prefs/prefs.dart';
import 'package:logistics/profile/entity/profile_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final Dio dio = Dio();

  postData(data, String Endpoints) async {
    try {
      var response = await dio.post(
        Endpoints,
        data: data,
      );
      return response;
    } catch (e) {
      print('Error111: $e');
    }
  }

  getData(String endpoint) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    final preHelper = PrefsHelper(sp);

    // Adding Authorization header if the token exists
    var headers = {'Authorization': 'Bearer ${preHelper.getUserToken}'};
    var response = await dio.get(
      endpoint,
      options: Options(headers: headers),
    );

    if (response.statusCode == 200) {
      print('Response Data: ${jsonEncode(response.data)}');

      return response.data;
    } else {
      print('Error: ${response.statusMessage}');
      return null;
    }
  }

  Future<void> _saveProfileEntityData(responseData) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    final preHelper = PrefsHelper(sp);

    // Assuming the API response contains the ProfileEntity data
    ProfileEntity profileEntity = ProfileEntity.fromJson(responseData);

    // Save ProfileEntity in SharedPreferences
    await preHelper.saveProfileEntity(profileEntity);

    // Retrieve and print the saved ProfileEntity
    ProfileEntity? retrievedEntity = preHelper.getProfileEntity();
    print("Saved ProfileEntity Name: ${retrievedEntity?.name}");
    print("Authorization Token: ${preHelper.getUserToken}");
  }

  //
  // getData(String Endpoints) async {
  //   SharedPreferences sp = await SharedPreferences.getInstance();
  //   final preHelper = PrefsHelper(sp);
  //   var headers = {'Authorization': '${preHelper.getUserToken}'};
  //   var dio = Dio();
  //   var response = await dio.request(
  //     Endpoints,
  //     options: Options(
  //       method: 'GET',
  //       headers: headers,
  //     ),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     print('ssssssssssssssssssssssssssssssssssssssssssss');
  //     print(json.encode(response.data));
  //     return response;
  //   } else {
  //     print(response.statusMessage);
  //   }
  // }
}
