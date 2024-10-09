import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logistics/constants/colors.dart';
import 'package:logistics/constants/images.dart';
import 'package:logistics/drawar/driver_drawar.dart';
import 'package:logistics/i18n/strings.g.dart';
import 'package:logistics/orders/enum/order_status_enum.dart';
import 'package:logistics/orders/providers/orders_provider.dart';
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
  bool isSearch = false;
  final TextEditingController _SearchController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(ordersProvider.notifier).getOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderListProvider = ref.watch(ordersProvider);
    final orderNotifier = ref.watch(ordersProvider.notifier);
    final isLoading = orderNotifier.isLoading; // Track loading state
    final error = orderNotifier.error;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:
          orderListProvider.isEmpty ? Colors.white : ColorsApp.backgroundColor,
      drawer: DriverDrawar(),
      appBar: myAppBar(context),
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
          isSearch == true
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: TextFormField(
                    controller: _SearchController,
                    onChanged: (value) {
                      setState(() {
                        ref.read(orderSearchProvider.notifier).state =
                            value.isNotEmpty ? value : '';
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "${t.Search}",
                      hintStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: ColorsApp.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0.sp),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0.sp, horizontal: 20.0.sp),
                      prefixIcon: Icon(
                        Icons.search,
                        color: ColorsApp.primaryColor,
                      ),
                    ),
                  ),
                )
              : SizedBox(
                  height: 0,
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                t.order,
              ),
              Text(
                ' ${orderListProvider.length} ',
              ),
              Icon(Icons.arrow_drop_down_outlined),
            ],
          ),
          if (isLoading) // Show a loading indicator when loading
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: CircularProgressIndicator(),
              ),
            )
          else if (error !=
              null) // Show an error message when there is an error
            Center(
              child: Text(
                'Error loading orders: $error',
                style: TextStyle(color: Colors.red),
              ),
            )
          else if (orderListProvider.isEmpty)
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 50.0.sp),
                  child: Image.asset(
                    ImageAssets.nullPackage,
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  width: 160.w,
                  child: ElevatedButton(
                      onPressed: () {
                        initState();
                        ref.read(ordersProvider.notifier).getOrders();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            ColorsApp.backgroundColor),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.refresh,
                            color: Colors.black,
                          ),
                          Text(
                            '${t.Reloading}',
                            style: TextStyle(
                              color: ColorsApp.black,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            )
          else
            Expanded(
              child: ListView.builder(
                controller: controller,
                itemCount: orderListProvider.length,
                itemBuilder: (context, index) {
                  return buildOrderCard(
                    name:
                        orderListProvider[index].destinationAddress.toString(),
                    numberOfLength: index + 1,
                    orderNumber: orderListProvider[index].barcode.toString(),
                    lat: orderListProvider[index].sourceLatitude.toString(),
                    long: orderListProvider[index].sourceLongitude.toString(),
                    statusCard:
                        orderListProvider[index].orderStatus, // Updated line
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  AppBar myAppBar(BuildContext context) {
    return AppBar(
      title: Text(t.orders),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            setState(() {
              isSearch = !isSearch;
            });
          },
        ),
        IconButton(
          icon: Icon(Icons.autorenew_rounded),
          onPressed: () {
            initState();
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              ref.read(ordersProvider.notifier).getOrders();
            });
          },
        ),
        IconButton(
          icon: Icon(Icons.qr_code_scanner),
          onPressed: () {
            scanQRCode();
          },
        ),
        IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {
            _showTopModalSheet(context);
          },
        ),
      ],
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
                    children: OrderStatus.values
                        .map((e) => _buildRadioOption(e.title, e.index))
                        .toList(),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildRadioOption(String title, int numberOfStatus) {
    //final OrderDataR = ref.watch(OrdersProvider.notifier);

    return RadioListTile<String>(
      title: Text(title),
      value: title,
      groupValue: ref.watch(orderFilterProvider.notifier).state.title,
      onChanged: (value) {
        setState(() {
          _selectedOption = value!;
          ref.read(orderFilterProvider.notifier).state = OrderStatus.values
              .firstWhere((element) => element.title == value);
          //OrderDataR.state[index].statusOrder = numberOfStatus;
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
        if (getResult.toString() != '-1') {
          ref.read(orderSearchProvider.notifier).state =
              getResult.toString().isNotEmpty ? getResult.toString() : '';
        }
      });

      print("QRCode_Result:--");
      print(qrCode);
    } on PlatformException {
      getResult = 'Failed to scan QR Code.';
    }
  }
}
