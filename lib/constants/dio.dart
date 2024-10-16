import 'dart:convert';
import 'dart:io';

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
    print("tokeen: ${preHelper.getUserToken}");
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

    var data = FormData.fromMap({'request_id': '${requestId}'});

    var response = await dio.request(
      endpoint.toString(),
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(
          "startMissionnnnnnnnnnnnnnnnnnnnnnnn: ${json.encode(response.data)}");
      return response.data;
    } else {
      print(response.statusMessage);
      return null;
    }
  }

  postReject(
      String endpoint, ref, String reasonsRejection, String requestId) async {
    final preHelper = ref.read(prefHelperProvider);

    var headers = {'Authorization': 'Bearer ${preHelper.getUserToken}'};

    var data = FormData.fromMap({
      'reasons_rejection': reasonsRejection.toString(),
      'request_id': requestId.toString()
    });

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
      return response.data;
    } else {
      print(response.statusMessage);
    }
  }

  getReasonsRejection(String endpoint, ref) async {
    final preHelper = ref.read(prefHelperProvider);

    var headers = {'Authorization': 'Bearer ${preHelper.getUserToken}'};

    var dio = Dio();
    var response = await dio.request(
      endpoint,
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
      return response.data;
    } else {
      print(response.statusMessage);
    }
  }

  postSendersSig(String endpoint, ref, File file1, File file2, String requestId,
      String step, String comment) async {
    final preHelper = ref.read(prefHelperProvider);

    var headers = {'Authorization': 'Bearer ${preHelper.getUserToken}'};

    FormData data = FormData.fromMap({
      'signature': await MultipartFile.fromFile(
        file2.path,
        filename: file2.path.split('/').last,
        // contentType: hp.MediaType.parse(contentType),
      ),
      'image': await MultipartFile.fromFile(
        file1.path,
        filename: file1.path.split('/').last,
        // contentType: hp.MediaType.parse(contentType)
      ),
      'request_id': '${requestId}',
      'step': '${step}',
      'comment': '${comment}'
    });

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
    } else {
      print(response.statusMessage);
    }
  }

  postArrived(String endpoint, ref, String requestId) async {
    final preHelper = ref.read(prefHelperProvider);

    var headers = {'Authorization': 'Bearer ${preHelper.getUserToken}'};

    var data = FormData.fromMap({'request_id': requestId});

    var dio = Dio();
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
      return response.statusCode;
    } else {
      print(response.statusMessage);
    }
  }
}
