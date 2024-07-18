import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics/orders/entity/orders_entity.dart';
import 'package:logistics/orders/repository/orders_repository.dart';

final localOrdersRepository = StateProvider((ref) => LocalOrdersRepository());

class LocalOrdersRepository implements OrdersRepository {
  @override
  OrdersEntity getOrders() {
    return OrdersEntity(
        name: 'hadeel',
        orderNumber: '88888',
        Orderlat: 33.509883,
        Orderlong: 36.305231,
        statusOrder: 2);
  }
}
