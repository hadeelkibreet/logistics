import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics/orders/entity/orders_entity.dart';
import 'package:logistics/orders/repository/orders_repository.dart';

final remoteOrdersRepository = Provider((ref) => RemoteOrdersRepository());

class RemoteOrdersRepository implements OrdersRepository {
  @override
  List<OrdersEntity> getOrders() {
    throw UnimplementedError();
  }
}
