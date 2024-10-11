import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics/constants/dio.dart';
import 'package:logistics/constants/endpoints.dart';
import 'package:logistics/orders/entity/orders_entity.dart';
import 'package:logistics/orders/repository/orders_repository.dart';

final remoteOrdersRepository = Provider((ref) => RemoteOrdersRepository(ref));

class RemoteOrdersRepository implements OrdersRepository {
  final ProviderRef<Object?> ref;

  // Constructor takes the ProviderRef and stores it as an instance variable
  RemoteOrdersRepository(this.ref);

  @override
  Future<List<OrdersEntity>> getOrders() async {
    // No ref in this method signature
    try {
      // Assuming ApiService is already set up for making HTTP requests
      var responseData =
          await ApiService().postAllOrdersData(Endpoints.getRequests, ref);
      // Assuming the responseData is a list of orders in JSON format
      List ordersJsonList = responseData;

      // Parse the list of orders
      List<OrdersEntity> ordersList = ordersJsonList
          .map((orderJson) => OrdersEntity.fromJson(orderJson))
          .toList();
      print("${ordersList.length}");
      return ordersList;
    } catch (e) {
      throw Exception('Failed to load orders: $e');
    }
  }

  Future<OrdersEntity> getStartMission(String ID) async {
    try {
      var responsData = await ApiService()
          .postStartMission(Endpoints.startMission, ref, ID.toString());
      OrdersEntity ordersEntity = OrdersEntity.fromJson(responsData);
      print("Orders Entity: ${ordersEntity.id}");
      return ordersEntity;
    } catch (e) {
      throw Exception('Faild to start mission: $e');
    }
  }
}
