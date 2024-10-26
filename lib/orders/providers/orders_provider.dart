import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics/orders/enum/order_type_enum.dart';
import 'package:logistics/orders/repository/orders_repository.dart';
import 'package:logistics/orders/repository/remote_orders_repository.dart';

import '../entity/orders_entity.dart';

final orderFilterProvider =
    StateProvider<OrderType>((ref) => OrderType.loading);

final orderSearchProvider = StateProvider<String>((ref) => '');

final ordersProvider =
    StateNotifierProvider<OrderStateNotifier, List<OrdersEntity>>((ref) {
  ref.read(remoteOrdersRepository);
  return OrderStateNotifier(
      repository: ref.watch(remoteOrdersRepository),
      filter: ref.read(orderFilterProvider),
      search: ref.watch(orderSearchProvider))
    ..getOrders(type: ref.read(orderFilterProvider))
    ..getOrdersBySearch();
});

class OrderStateNotifier extends StateNotifier<List<OrdersEntity>> {
  OrderStateNotifier(
      {required this.repository, required this.filter, required this.search})
      : super([]);

  final OrdersRepository repository;
  final OrderType filter;
  String search;

  List<OrdersEntity> _list = [];
  List<OrdersEntity> _display = [];
  // Variables to track the loading and error states
  bool isLoading = false;
  String? error;

  Future<void> getOrders({required OrderType type}) async {
    isLoading = true; // Start loading
    error = null; // Reset error before fetching
    try {
      _list = await repository.getOrders(type);
      _display = _list;
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

  List<String> getFilterOptions() {
    final uniqueStatuses = OrderType.values
        .map(
          (e) => e.name,
        )
        .toList();
    return uniqueStatuses;
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
