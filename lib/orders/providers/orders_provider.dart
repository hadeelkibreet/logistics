import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics/orders/repository/local_orders_repository.dart';

final OrdersProvider = StateProvider(
  (ref) => ref.read(localOrdersRepository).getOrders(),
);
