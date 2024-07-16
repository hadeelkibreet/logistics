import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logistics/constants/colors.dart';
import 'package:logistics/drawar/driver_drawar.dart';
import 'package:logistics/i18n/strings.g.dart';
import 'package:logistics/orders/widget/card_orders.dart';

class ActiveOrders extends ConsumerStatefulWidget {
  @override
  _ActiveOrdersState createState() => _ActiveOrdersState();
}

class _ActiveOrdersState extends ConsumerState<ActiveOrders> {
  var getResult = 'QR Code Result';
  final ScrollController controller = ScrollController();
  String _selectedOption = 'جميع الطلبات';
  late bool isdone = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.backgroundColor,
      drawer: DriverDrawar(),
      appBar: AppBar(
        title: Text(t.orders),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.autorenew_rounded),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: () {
              scanQRCode();
              //  QRCode();
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              _showTopModalSheet(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.green,
            padding: EdgeInsets.all(5.0.sp),
            child: Text(
              t.InService,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 18.sp),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                t.order,
              ),
              Text(
                '${1}   ',
              ),
              Icon(Icons.arrow_drop_down_outlined),
            ],
          ),
          Expanded(
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
                  isdone: isdone,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showTopModalSheet(BuildContext context) {
    final double leftshowTopModalSheet = isdone ? 0 : 150.sp;
    final double rightshowTopModalSheet = isdone ? 150.sp : 0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Positioned(
              top: 3.sp,
              left: leftshowTopModalSheet,
              right: rightshowTopModalSheet,
              child: Container(
                width: 10.w,
                child: Material(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      _buildRadioOption(t.allOrders),
                      _buildRadioOption(t.delivery),
                      _buildRadioOption(t.LoadingTheShipment),
                      _buildRadioOption(t.tryy),
                      _buildRadioOption(t.notTry),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildRadioOption(String title) {
    return RadioListTile<String>(
      title: Text(title),
      value: title,
      groupValue: _selectedOption,
      onChanged: (value) {
        setState(() {
          _selectedOption = value!;
          value == t.delivery ? isdone = true : isdone = false;
        });
        Navigator.pop(context);
      },
    );
  }

  void scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);

      if (!mounted) return;

      setState(() {
        getResult = qrCode;
      });

      print("QRCode_Result:--");
      print(qrCode);
    } on PlatformException {
      getResult = 'Failed to scan QR Code.';
    }
  }
}
