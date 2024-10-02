import 'package:dio/dio.dart';
import 'package:logistics/auth/entity/login_entity.dart';
import 'package:logistics/constants/endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/prefs/prefs.dart';

class ApiService {
  final Dio dio = Dio();

  Future<void> postData(data) async {
    try {
      var response = await dio.post(
        Endpoints.login.toString(),
        data: data,
      );

      if (response.statusCode == 200) {
        LoginEntity loginEntity = LoginEntity.fromJson(response.data);
        SharedPreferences sp = await SharedPreferences.getInstance();
        final preHelper = PrefsHelper(sp);

        if (!preHelper.getUserToken.contains("Bearer")) {
          await preHelper.setUserToken(loginEntity.accessToken);
        }
        await preHelper.saveLoginEntity(loginEntity);
        LoginEntity? infoEntity = preHelper.getLoginEntity();
        print(infoEntity!.user.name.toString());
        print(preHelper.getUserToken);
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
