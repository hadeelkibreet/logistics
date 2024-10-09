import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics/orders/enum/order_status_enum.dart';
import 'package:logistics/orders/repository/orders_repository.dart';
import 'package:logistics/orders/repository/remote_orders_repository.dart';

import '../entity/orders_entity.dart';

final OrdersProvider2 = StateProvider(
  (ref) => ref.read(remoteOrdersRepository).getOrders(),
);

final orderFilterProvider = StateProvider((ref) => OrderStatus.allOrders);

final orderSearchProvider = StateProvider((ref) => '');

final ordersProvider =
    StateNotifierProvider<OrderStateNotifier, List<OrdersEntity>>((ref) {
  ref.read(remoteOrdersRepository);
  return OrderStateNotifier(
      repository: ref.watch(remoteOrdersRepository),
      filter: ref.watch(orderFilterProvider),
      Search: ref.watch(orderSearchProvider))
    ..getOrders()
    ..getOrdersBySearch();
});

class OrderStateNotifier extends StateNotifier<List<OrdersEntity>> {
  OrderStateNotifier(
      {required this.repository, required this.filter, required this.Search})
      : super([]);

  OrdersRepository repository;
  List<OrdersEntity> _list = [];
  List<OrdersEntity> _display = [];
  OrderStatus filter;
  String Search;
  Future<void> getOrders() async {
    _list = await repository.getOrders();
    _display = _list;
    if (filter != OrderStatus.allOrders) {
      _display = _list.where((element) => element.barcode == filter).toList();
    }

    state = _display;
  }

  void getOrdersBySearch() {
    if (Search.toString().isEmpty) {
      _display = _list;
      state = _display;
      return;
    }
    _display = _list
        .where((element) => element.barcode.startsWith(Search.toString()))
        .toList();

    state = _display;
  }
}
