import 'package:flutter/material.dart';
import 'package:logistics/i18n/strings.g.dart';

enum OrderStatus {
  allOrders(
    color: Colors.black,
  ),
  Delivery_Rejected(color: Colors.green),
  loadingTheShipment(color: Colors.amber),
  tryy(color: Colors.lightBlue),
  notTry(color: Colors.red);

  final Color color;
  const OrderStatus({required this.color});
}

extension OrderStatusExt on OrderStatus {
  String get title {
    switch (this) {
      case OrderStatus.allOrders:
        return t.allOrders;
      case OrderStatus.Delivery_Rejected:
        return t.delivery;
      case OrderStatus.loadingTheShipment:
        return t.LoadingTheShipment;
      case OrderStatus.tryy:
        return t.tryy;
      case OrderStatus.notTry:
        return t.notTry;
    }
  }
}
