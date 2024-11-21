import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics/orders/entity/positioned_order_entity.dart';
import 'package:logistics/orders/enum/order_type_enum.dart';
import 'package:logistics/orders/repository/orders_repository.dart';
import 'package:logistics/orders/repository/remote_orders_repository.dart';

import '../entity/orders_entity.dart';

final orderFilterProvider =
    StateProvider<OrderType>((ref) => OrderType.loading);

final orderSearchProvider = StateProvider<String>((ref) => '');

final positionedOrdersProvider =
    StateNotifierProvider<OrderStateNotifier, List<PositionedOrderEntity>>(
        (ref) {
  ref.read(remoteOrdersRepository);
  return OrderStateNotifier(
      repository: ref.watch(remoteOrdersRepository),
      filter: ref.read(orderFilterProvider),
      search: ref.watch(orderSearchProvider))
    ..getOrders(type: ref.read(orderFilterProvider));
});

class OrderStateNotifier extends StateNotifier<List<PositionedOrderEntity>> {
  OrderStateNotifier(
      {required this.repository, required this.filter, required this.search})
      : super([]);

  final OrdersRepository repository;
  final OrderType filter;
  String search;

  List<OrdersEntity> _list = [];
  List<PositionedOrderEntity> _display = [];
  // Variables to track the loading and error states
  bool isLoading = false;
  String? error;

  Future<void> getOrders({required OrderType type}) async {
    isLoading = true; // Start loading
    error = null; // Reset error before fetching
    try {
      _list = await repository.getOrders(type);
      _display = getOrdersByDestinationName(_list);
      state = _display;
    } catch (e) {
      error = e.toString(); // Set error message on failure
    } finally {
      isLoading = false; // Stop loading
    }
  }

  List<PositionedOrderEntity> getOrdersByDestinationName(
      List<OrdersEntity> list) {
    List<OrdersEntity> sortedList = list;
    sortedList.sort(
      (a, b) => a.destinationName.compareTo(b.destinationName),
    );
    final List<PositionedOrderEntity> destinationNames = [
      PositionedOrderEntity(orders: list, destinationName: 'all', position: 0),
    ];
    int counter = 1;

    for (int index = 0; index < sortedList.length; index++) {
      OrdersEntity ordersEntity = sortedList[index];
      int whereIndex = destinationNames.indexWhere(
        (element) => element.destinationName == ordersEntity.destinationName,
      );

      if (whereIndex == -1) {
        destinationNames.add(
          PositionedOrderEntity(
            orders: [ordersEntity],
            destinationName: ordersEntity.destinationName,
            position:
                counter, // Use the index here if that makes sense for your logic
          ),
        );
        counter = counter + 1;
      } else {
        whereIndex;
        destinationNames[whereIndex].orders.add(ordersEntity);
      }
    }
    print(destinationNames);
    return destinationNames;
  }

  List<String> getFilterOptions() {
    final uniqueStatuses = OrderType.values
        .map(
          (e) => e.name,
        )
        .toList();
    return uniqueStatuses;
  }

  // void getOrdersBySearch() {
  //   if (search.isEmpty) {
  //     _display = _list;
  //   } else {
  //     _display =
  //         _list.where((element) => element.barcode.startsWith(search)).toList();
  //   }
  //   state = _display;
  // }

  // void updateSearch(String newSearch) {
  //   search = newSearch;
  //   getOrdersBySearch();
  // }
}
