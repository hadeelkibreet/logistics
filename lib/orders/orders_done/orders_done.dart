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
    final orderListProvider = ref.watch(ordersProvider.notifier).state;
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
              itemCount: orderListProvider.length,
              itemBuilder: (context, index) {
                return buildOrderCard(
                  name: orderListProvider[index].name,
                  numberOfLength: 2,
                  orderNumber: orderListProvider[index].orderNumber,
                  lat: orderListProvider[index].Orderlat,
                  long: orderListProvider[index].Orderlong,
                  statusCard: orderListProvider[index].statusOrder,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
