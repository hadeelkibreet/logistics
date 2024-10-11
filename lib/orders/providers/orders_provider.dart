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
      search: ref.watch(orderSearchProvider))
    ..getOrders()
    ..getOrdersBySearch();
});

class OrderStateNotifier extends StateNotifier<List<OrdersEntity>> {
  OrderStateNotifier(
      {required this.repository, required this.filter, required this.search})
      : super([]) {
    getOrders(); // Automatically fetch orders when initialized
  }

  final OrdersRepository repository;
  final OrderStatus filter;
  String search;

  List<OrdersEntity> _list = [];
  List<OrdersEntity> _display = [];

  // Variables to track the loading and error states
  bool isLoading = false;
  String? error;

  Future<void> getOrders() async {
    isLoading = true; // Start loading
    error = null; // Reset error before fetching
    try {
      _list = await repository.getOrders();
      _display = _list;

      // Apply the filter if needed
      if (filter != OrderStatus.allOrders) {
        _display =
            _list.where((element) => element.orderStatus == filter).toList();
      }

      // Apply search filter if there's a search term
      if (search.isNotEmpty) {
        getOrdersBySearch();
      }

      state = _display;
    } catch (e) {
      error = e.toString(); // Set error message on failure
    } finally {
      isLoading = false; // Stop loading
    }
  }

  void getOrdersBySearch() {
    if (search.isEmpty) {
      _display = _list;
    } else {
      _display =
          _list.where((element) => element.barcode.startsWith(search)).toList();
    }
    state = _display;
  }

  void updateSearch(String newSearch) {
    search = newSearch;
    getOrdersBySearch();
  }
}

final IDProvider = StateProvider<String>((ref) => '');
//
// final orderDetilsProvider = FutureProvider<DetilsEntity>((ref) async {
//   final repository = await ref.read(remoteOrdersRepository);
//
//   return await repository.getStartMission(ref.read(IDProvider.notifier).state);
// });
