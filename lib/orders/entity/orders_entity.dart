import 'package:logistics/orders/enum/order_status_enum.dart';

class OrdersEntity {
  final String name;
  final String orderNumber;
  final double Orderlat;
  final double Orderlong;
  final OrderStatus statusOrder;

  OrdersEntity(
      {required this.name,
      required this.orderNumber,
      required this.Orderlat,
      required this.Orderlong,
      required this.statusOrder});
}
