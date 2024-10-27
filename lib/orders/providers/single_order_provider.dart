import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics/constants/endpoints.dart';
import 'package:logistics/core/network/api_client.dart';
import 'package:logistics/data/prefs/prefs.dart';
import 'package:logistics/orders/entity/detils_entity.dart';

final singleOrderProvider =
    StateNotifierProvider<SingleOrderStateNotifier, DetilsEntity?>(
  (ref) => SingleOrderStateNotifier(
    null,
    apiClient: ref.watch(apiClientProvider),
    prefsHelper: ref.read(prefHelperProvider),
  ),
);

class SingleOrderStateNotifier extends StateNotifier<DetilsEntity?> {
  SingleOrderStateNotifier(
    super.state, {
    required this.prefsHelper,
    required this.apiClient,
  });

  final PrefsHelper prefsHelper;
  final ApiClient apiClient;

  Future<void> getOrder(int id) async {
    try {
      final Response response = await apiClient.post(
        Endpoints.startMission,
        data: {'request_id': id},
      );
      List<dynamic> orderList = response.data;
      DetilsEntity detailsEntity = DetilsEntity.fromJson(orderList.first);
      state = detailsEntity;
    } catch (e) {
      throw Exception('Failed to load orders: $e');
    }
  }
}
