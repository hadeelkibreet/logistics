import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics/constants/dio.dart';
import 'package:logistics/data/prefs/prefs.dart';
import 'package:logistics/orders/entity/detils_entity.dart';

final singleOrderProvider =
    StateNotifierProvider<SingleOrderStateNotifier, DetilsEntity?>(
  (ref) => SingleOrderStateNotifier(
    null,
    ref.read(prefHelperProvider),
  ),
);

class SingleOrderStateNotifier extends StateNotifier<DetilsEntity?> {
  SingleOrderStateNotifier(super.state, this.prefsHelper);
  final PrefsHelper prefsHelper;
  Future<void> getOrder(int id) async {
    print(prefsHelper.getUserToken);
    try {
      var responseData =
          await ApiService().getSingleOrder(prefsHelper.getUserToken, id);
      List<dynamic> ordersJson = responseData;
      DetilsEntity detailsEntity = DetilsEntity.fromJson(ordersJson.first);
      state = detailsEntity;
    } catch (e) {
      throw Exception('Failed to load orders: $e');
    }
  }
}
