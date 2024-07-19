import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics/orders/entity/orders_entity.dart';
import 'package:logistics/orders/enum/order_status_enum.dart';
import 'package:logistics/orders/repository/orders_repository.dart';

final localOrdersRepository = Provider((ref) => LocalOrdersRepository());

class LocalOrdersRepository implements OrdersRepository {
  @override
  List<OrdersEntity> getOrders() {
    Random random = Random();
    //random.nextInt(4);

    return List.generate(
      5,
      (index) {
        return OrdersEntity(
          name: 'Order #${index}',
          orderNumber: '${index * 4527}',
          Orderlat: 33.509883,
          Orderlong: 36.305231,
          statusOrder: OrderStatus.values[random.nextInt(4) + 1],
        );
      },
    )..add(OrdersEntity(
        name: 'hadeel',
        orderNumber: '6281072142971',
        Orderlat: 33.509883,
        Orderlong: 36.305231,
        statusOrder: OrderStatus.values[random.nextInt(4) + 1],
      ));
  }
}
