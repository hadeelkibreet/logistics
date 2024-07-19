import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics/orders/enum/order_status_enum.dart';
import 'package:logistics/orders/repository/local_orders_repository.dart';
import 'package:logistics/orders/repository/orders_repository.dart';
import 'package:logistics/orders/repository/remote_orders_repository.dart';

import '../entity/orders_entity.dart';

final OrdersProvider2 = StateProvider(
  (ref) => ref.read(localOrdersRepository).getOrders(),
);

final orderFilterProvider = StateProvider((ref) => OrderStatus.allOrders);

final ordersProvider =
    StateNotifierProvider<OrderStateNotifier, List<OrdersEntity>>((ref) {
  ref.read(remoteOrdersRepository);
  return OrderStateNotifier(
    repository: ref.watch(localOrdersRepository),
    filter: ref.watch(orderFilterProvider),
  )..getOrders();
});

class OrderStateNotifier extends StateNotifier<List<OrdersEntity>> {
  OrderStateNotifier({required this.repository, required this.filter})
      : super([]);

  OrdersRepository repository;
  List<OrdersEntity> _list = [];
  List<OrdersEntity> _display = [];
  OrderStatus filter;

  void getOrders() {
    _list = repository.getOrders();
    _display = _list;
    if (filter != OrderStatus.allOrders) {
      _display =
          _list.where((element) => element.statusOrder == filter).toList();
    }
    state = _display;
  }
}
