class OrdersEntity {
  final String name;
  final String orderNumber;
  final double Orderlat;
  final double Orderlong;
  int statusOrder;

  OrdersEntity(
      {required this.name,
      required this.orderNumber,
      required this.Orderlat,
      required this.Orderlong,
      required this.statusOrder});
}
