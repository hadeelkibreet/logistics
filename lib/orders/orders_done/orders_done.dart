import 'package:flutter/material.dart';
import 'package:logistics/constants/colors.dart';
import 'package:logistics/drawar/driver_drawar.dart';
import 'package:logistics/orders/widget/card_orders.dart';

class OrdersDone extends StatefulWidget {
  const OrdersDone({Key? key}) : super(key: key);

  @override
  State<OrdersDone> createState() => _OrdersDoneState();
}

class _OrdersDoneState extends State<OrdersDone> {
  @override
  Widget build(BuildContext context) {
    final ScrollController controller = ScrollController();

    return Scaffold(
      backgroundColor: ColorsApp.backgroundColor,
      drawer: DriverDrawar(),
      appBar: AppBar(
        title: Text('أكتمل'),
        centerTitle: true,
      ),
      body: Expanded(
        child: ListView.builder(
          controller: controller,
          itemCount: 3,
          itemBuilder: (context, index) {
            return buildOrderCard(
              name:
                  'hhhhhhhhhhaddddddddddddddddddddeelkkkkkiiiibreeeeeeeeeeeeeeeeeeeetttttttttttttttttt',
              numberOfLength: 2,
              orderNumber:
                  '99997889999999999999999999999999999999999999999999999',
              lat: 9999999999,
              long: 9999999,
              isdone: true,
            );
          },
        ),
      ),
    );
  }
}
