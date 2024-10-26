import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics/orders/entity/detils_entity.dart';
import 'package:logistics/orders/entity/orders_entity.dart';
import 'package:logistics/orders/enum/order_type_enum.dart';

abstract class OrdersRepository {
  Future<List<OrdersEntity>> getOrders(OrderType type);
  Future<DetilsEntity> getSingleOrderDetails(WidgetRef ref, int orderId);
}
