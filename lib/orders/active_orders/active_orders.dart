import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logistics/constants/colors.dart';
import 'package:logistics/constants/images.dart';
import 'package:logistics/drawar/driver_drawar.dart';
import 'package:logistics/i18n/strings.g.dart';
import 'package:logistics/orders/enum/order_type_enum.dart';
import 'package:logistics/orders/providers/orders_provider.dart';
import 'package:logistics/orders/widget/card_orders.dart';

final activeOrderLoaderProvider = StateProvider<bool>(
  (ref) => false,
);

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
  int? _selectedId;

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   ref.read(ordersProvider.notifier).getOrders(type: OrderType.loading);
    // });
  }

  @override
  Widget build(BuildContext context) {
    final orderListProvider = ref.watch(ordersProvider);
    final orderNotifier = ref.watch(ordersProvider.notifier);
    final isLoading = orderNotifier.isLoading; // Track loading state
    final error = orderNotifier.error;

    bool _isLoading = false;

    Future<void> _simulateLoading() async {
      setState(() {
        _isLoading = true; // Show the loader
      });

      // Simulate a network request or some processing
      await Future.delayed(Duration(seconds: 2));

      setState(() {
        _isLoading = false; // Hide the loader
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:
          orderListProvider.isEmpty ? Colors.white : ColorsApp.backgroundColor,
      drawer: DriverDrawar(),
      appBar: myAppBar(context, orderListProvider),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                color: Colors.green,
                padding: EdgeInsets.all(5.0.sp),
                child: Text(
                  ref.watch(orderFilterProvider).name,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 18.sp),
                ),
              ),
              isSearch == true
                  ? Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 8),
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
                            ref
                                .read(ordersProvider.notifier)
                                .getOrders(type: ref.read(orderFilterProvider));
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
                        refNumber: orderListProvider[index].ref.toString(),
                        name: orderListProvider[index]
                            .destinationAddress
                            .toString(),
                        numberOfLength: index + 1,
                        orderNumber:
                            orderListProvider[index].barcode.toString(),
                        lat: orderListProvider[index].sourceLatitude.toString(),
                        long:
                            orderListProvider[index].sourceLongitude.toString(),
                        status: orderListProvider[index].status.toString(),
                        ID: orderListProvider[index].id, // Updated line
                      );
                    },
                  ),
                ),
            ],
          ),
          if (ref.watch(activeOrderLoaderProvider))
            ModalBarrier(
              dismissible: false, // Prevent dismissing by tapping outside
              color: Colors.black54,
            ),
          if (ref.watch(activeOrderLoaderProvider))
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  AppBar myAppBar(BuildContext context, getOrderProvider) {
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
          icon: const Icon(
            Icons.autorenew_rounded,
          ),
          onPressed: () {
            ref
                .read(ordersProvider.notifier)
                .getOrders(type: ref.read(orderFilterProvider));
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
          onPressed: () async {
            // Assuming the response is a list of JSON objects
            // final List<ReasonsRejectionStatusEntity> options =
            //     (ReasonsRejection as List)
            //         .map((json) => ReasonsRejectionStatusEntity.fromJson(json))
            //         .toList();
            // Now pass the list to the modal
            _showTopModalSheet(
                context, ref.watch(ordersProvider.notifier).getFilterOptions());
          },
        ),
      ],
    );
  }

  void _showTopModalSheet(BuildContext context, List<String> options) {
    final double leftshowTopModalSheet = isdone ? 0 : 150.sp;
    final double rightshowTopModalSheet = isdone ? 150.sp : 0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Use StatefulBuilder to manage the state within the dialog
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
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
                      child: ListView(
                        shrinkWrap:
                            true, // Prevent the ListView from taking up infinite height
                        children: options.map((option) {
                          return _buildRadioOption(option, option.length);
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Widget _buildRadioOption(OrdersEntity option,
  //     void Function(void Function()) setState) {
  //   return RadioListTile<int>(
  //     title: Text(
  //       option.status,
  //     ),
  //     value:ref.watch(orderFilterProvider.notifier).state.title ,
  //     groupValue: _selectedId, // Use the same groupValue
  //     onChanged: (int? value) {
  //       setState(() {
  //         _selectedId = value; // Set the selected id
  //       });
  //     },
  //   );
  // }

// Widget to build the radio option
  Widget _buildRadioOption(String title, int numberOfStatus) {
    return RadioListTile<String>(
      title: Text(title),
      value: title,
      groupValue: ref.watch(orderSearchProvider) == ''
          ? ref.watch(orderFilterProvider).name
          : '',
      onChanged: (value) {
        setState(() {
          _selectedOption = value!;
          ref.read(orderFilterProvider.notifier).state =
              OrderType.fromString(value);
          switch (OrderType.fromString(value)) {
            case OrderType.all:
              ref.watch(ordersProvider.notifier).getOrders(type: OrderType.all);
              break;
            case OrderType.loading:
              ref
                  .watch(ordersProvider.notifier)
                  .getOrders(type: OrderType.loading);
              break;
            case OrderType.delivery:
              ref
                  .watch(ordersProvider.notifier)
                  .getOrders(type: OrderType.delivery);
              break;
            default:
              ref.watch(ordersProvider.notifier).getOrders(type: OrderType.all);
          }
        });
        Navigator.pop(context);
      },
    );
  }

  void scanQRCode() async {
    // try {
    //   final qrCode = await FlutterBarcodeScanner.scanBarcode(
    //       '#ff6666', 'Cancel', true, ScanMode.QR);
    //
    //   if (!mounted) return;
    //
    //   setState(() {
    //     getResult = qrCode;
    //     print(qrCode);
    //
    //     if (getResult.toString() != '-1') {
    //       //  isSearch = !isSearch;
    //       ref.read(orderSearchProvider.notifier).state =
    //           getResult.isNotEmpty ? getResult : '';
    //     }
    //   });
    //
    //   print("QRCode_Result:--");
    //   print(qrCode);
    // } on PlatformException {
    //   getResult = 'Failed to scan QR Code.';
    // }
  }
}
