import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics/constants/dio.dart';
import 'package:logistics/constants/endpoints.dart';
import 'package:logistics/core/network/api_client.dart';
import 'package:logistics/data/prefs/prefs.dart';
import 'package:logistics/orders/entity/detils_entity.dart';
import 'package:logistics/orders/entity/orders_entity.dart';
import 'package:logistics/orders/enum/order_type_enum.dart';
import 'package:logistics/orders/repository/orders_repository.dart';

final remoteOrdersRepository = Provider(
  (ref) => RemoteOrdersRepository(
    ref,
    ref.read(prefHelperProvider),
    ref.watch(apiClientProvider),
  ),
);

class RemoteOrdersRepository implements OrdersRepository {
  final ProviderRef<Object?> ref;
  final PrefsHelper prefsHelper;
  final ApiClient apiClient;

  // Constructor takes the ProviderRef and stores it as an instance variable
  RemoteOrdersRepository(this.ref, this.prefsHelper, this.apiClient);

  @override
  Future<List<OrdersEntity>> getOrders(OrderType type) async {
    // No ref in this method signature
    try {
      final Response response = await apiClient.post(
        Endpoints.getRequests,
        data: {
          'type': type.name,
        },
      );
      // Assuming ApiService is already set up for making HTTP requests
      // var responseData = await ApiService()
      //     .postAllOrdersData(Endpoints.getRequests, ref, type.name);
      // Assuming the responseData is a list of orders in JSON format
      List ordersJsonList = response.data;

      // Parse the list of orders
      List<OrdersEntity> ordersList = ordersJsonList
          .map((orderJson) => OrdersEntity.fromJson(orderJson))
          .toList();
      return ordersList;
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to load orders: $e');
    }
  }

  Future<DetilsEntity> getStartMission(String id) async {
    try {
      final Response response = await apiClient.post(
        Endpoints.startMission,
        data: {'request_id': id},
      );
      List<dynamic> list = response.data;
      var firstOrderData = list.first;
      DetilsEntity ordersEntity = DetilsEntity.fromJson(firstOrderData);
      return ordersEntity;
    } catch (e) {
      throw Exception('Failed to start mission: $e');
    }
  }

  @override
  Future<void> getReject(String reasonsRejection, String requestId) async {
    try {
      await ApiService()
          .postReject(Endpoints.reject, ref, reasonsRejection, requestId);
    } catch (e) {
      throw Exception('Failed to start mission: $e');
    }
  }

  Future<void> postArrived(int id) async {
    try {
      final Response response = await apiClient.post(
        Endpoints.PostArrived,
        data: {'request_id': id},
      );
    } catch (e) {
      throw Exception('Failed to start mission: $e');
    }
  }

  @override
  Future<DetilsEntity> getSingleOrderDetails(int id) async {
    try {
      final Response response = await apiClient.post(
        Endpoints.getRequests,
        queryParameters: {'id': id},
      );
      List<dynamic> orderList = response.data;
      DetilsEntity detailsEntity = DetilsEntity.fromJson(orderList.first);
      return detailsEntity;
    } catch (e) {
      throw Exception('Failed to load orders: $e');
    }
  }
}
