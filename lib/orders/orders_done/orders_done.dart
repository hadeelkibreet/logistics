import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics/constants/colors.dart';
import 'package:logistics/drawar/driver_drawar.dart';
import 'package:logistics/orders/providers/orders_provider.dart';
import 'package:logistics/orders/widget/card_orders.dart';

class OrdersDon extends ConsumerStatefulWidget {
  @override
  _OrdersDonState createState() => _OrdersDonState();
}

class _OrdersDonState extends ConsumerState<OrdersDon> {
  var getResult = 'QR Code Result';
  final ScrollController controller = ScrollController();
  String _selectedOption = 'جميع الطلبات';
  late bool isdone = false;

  @override
  Widget build(BuildContext context) {
    final OrderData = ref.watch(OrdersProvider.notifier);
    return Scaffold(
      backgroundColor: ColorsApp.backgroundColor,
      drawer: DriverDrawar(),
      appBar: AppBar(
        title: Text('أكتمل'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: controller,
              itemCount: 3,
              itemBuilder: (context, index) {
                return buildOrderCard(
                  name: OrderData.state.name,
                  numberOfLength: 2,
                  orderNumber: OrderData.state.orderNumber,
                  lat: OrderData.state.Orderlat,
                  long: OrderData.state.Orderlong,
                  statusCard: 1,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
