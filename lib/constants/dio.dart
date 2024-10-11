import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logistics/data/prefs/prefs.dart';

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

  getData(String endpoint, ref) async {
    final preHelper = ref.read(prefHelperProvider);

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

  postAllOrdersData(String endpoint, ref) async {
    final preHelper = ref.read(prefHelperProvider);

    var data = FormData.fromMap({'type': 'all'});
    var headers = {'Authorization': 'Bearer ${preHelper.getUserToken}'};

    var response = await dio.request(
      endpoint.toString(),
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      //print("hiiiiiiiiiii: ${json.encode(response.data)}");
      return response.data;
    } else {
      print(response.statusMessage);
      return null;
    }
  }

  postStartMission(String endpoint, ref, String requestId) async {
    final preHelper = ref.read(prefHelperProvider);

    // Adding Authorization header if the token exists
    var headers = {'Authorization': 'Bearer ${preHelper.getUserToken}'};

    var data = FormData.fromMap({'request_id': requestId.toString()});

    var response = await dio.request(
      endpoint.toString(),
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
      print(
          "startMissionnnnnnnnnnnnnnnnnnnnnnnn: ${json.encode(response.data)}");
    } else {
      print(response.statusMessage);
    }
  }
}
