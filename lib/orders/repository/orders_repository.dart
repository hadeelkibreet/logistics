import 'package:logistics/orders/entity/orders_entity.dart';

abstract class OrdersRepository {
  OrdersEntity getOrders();
}
