import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:logistics/constants/colors.dart';
import 'package:logistics/constants/dio.dart';
import 'package:logistics/constants/endpoints.dart';
import 'package:logistics/constants/images.dart';
import 'package:logistics/i18n/strings.g.dart';
import 'package:logistics/logistic_app.dart';
import 'package:logistics/orders/detils_order/bottom_navigationBar.dart';
import 'package:logistics/orders/entity/detils_entity.dart';
import 'package:logistics/orders/entity/reasons_rejection_entity.dart';
import 'package:logistics/orders/providers/single_order_provider.dart';
import 'package:logistics/orders/repository/remote_orders_repository.dart';
import 'package:logistics/orders/senders_signature/senders_signature_screen.dart';
import 'package:signature/signature.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/orders_provider.dart';

final orderDetailsScreenLoaderProvider = StateProvider<bool>(
  (ref) => false,
);

class OrderDetailsScreen extends ConsumerStatefulWidget {
  final DetilsEntity DetilsData;

  const OrderDetailsScreen({super.key, required this.DetilsData});

  @override
  ConsumerState<OrderDetailsScreen> createState() => _detailsOrderScreenState();
}

class _detailsOrderScreenState extends ConsumerState<OrderDetailsScreen> {
  late SignatureController _controllerSignature;
  late final DetilsEntity detailsEntity;
  File? _image;
  late bool isShow = true;
  @override
  void initState() {
    // _initState();
    super.initState();
    // _loadingPro();
    _controllerSignature = SignatureController(
      penStrokeWidth: 5,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white,
    );

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        try {
          ref.read(orderDetailsScreenLoaderProvider.notifier).state = true;
          await ref
              .read(singleOrderProvider.notifier)
              .getOrder(widget.DetilsData.id);
          ref.read(orderDetailsScreenLoaderProvider.notifier).state = false;
        } catch (e) {
          ref.read(orderDetailsScreenLoaderProvider.notifier).state = false;
          ref.read(navigatorProvider).pop();
        }
      },
    );
  }

  @override
  void dispose() {
    _controllerSignature.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orderDetails = ref.watch(singleOrderProvider);
    String destinationName =
        (ref.watch(singleOrderProvider)?.destinationName.substring(0, 1)) ?? "";
    return Scaffold(
      backgroundColor: ColorsApp.backgroundColor,
      body: Skeletonizer(
        enabled: ref.watch(orderDetailsScreenLoaderProvider),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    color: ColorsApp.backgroundColor,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 300.h,
                              child: Stack(
                                children: [
                                  FlutterMap(
                                    options: MapOptions(
                                      center: LatLng(
                                          24.88, 34.986), // إحداثيات الموقع
                                      zoom: 15.0.sp,
                                    ),
                                    children: [
                                      TileLayer(
                                        urlTemplate:
                                            'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                                        subdomains: ['a', 'b', 'c'],
                                      ),
                                      MarkerLayer(
                                        markers: [
                                          Marker(
                                            width: 80.0.w,
                                            height: 80.0.h,
                                            point: LatLng(24.778810,
                                                46.730354), // إحداثيات الموقع
                                            builder: (ctx) => Icon(
                                              Icons.location_on,
                                              color: Colors.red,
                                              size: 40.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Positioned.fill(
                                    child: Material(
                                      color: Color(0x629D9D9D),
                                      child: InkWell(
                                        onTap: _launchMapsUrl,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 60.sp),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.red,
                                      child: Text(
                                        destinationName,
                                        style:
                                            TextStyle(color: ColorsApp.white),
                                      ),
                                    ),
                                    Text(
                                      destinationName, // 'test',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      widget.DetilsData.destinationAddress
                                          .toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 80.h,
                                    ),
                                    Text(
                                      '${t.orderNumber + widget.DetilsData.barcode} ',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 23.sp,
                                          color: ColorsApp.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    if (false)
                                      Padding(
                                        padding: EdgeInsets.only(top: 28.sp),
                                        child: Container(
                                          color: ColorsApp.backgroundColor,
                                          width: double.infinity,
                                          padding: EdgeInsets.all(8.7.sp),
                                          child: Text(
                                            t.accept,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18.sp),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 300.sp),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0.sp),
                                        child: InkWell(
                                          onTap: () => refresh(),
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            child: Icon(Icons.refresh),
                                            maxRadius: 25.sp,
                                            minRadius: 25.sp,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(10.0.sp),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.green,
                                          child: IconButton(
                                            icon: Icon(Icons.phone,
                                                color: ColorsApp.white),
                                            onPressed: () {
                                              callNumber(widget.DetilsData
                                                  .destinationNumberPhone
                                                  .toString());
                                            },
                                          ),
                                          maxRadius: 25.sp,
                                          minRadius: 25.sp,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0.sp),
                                        child: InkWell(
                                          onTap: () => openWhatsApp(widget
                                              .DetilsData.destinationNumberPhone
                                              .toString()),
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            child: Image.asset(
                                              ImageAssets.whatsapp,
                                              height: 25.h,
                                              width: 25.w,
                                            ),
                                            maxRadius: 25.sp,
                                            minRadius: 25.sp,
                                          ),
                                        ),
                                      ),
                                      if (false)
                                        Padding(
                                          padding: EdgeInsets.all(8.0.sp),
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            child: IconButton(
                                              icon: Icon(Icons.cloud_download,
                                                  color: Colors.grey),
                                              onPressed: () {
                                                //   downloadAndConvertImageToPDF();
                                              },
                                            ),
                                            maxRadius: 25.sp,
                                            minRadius: 25.sp,
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (false) ...[
                    Padding(
                      padding: EdgeInsets.all(5.0.sp),
                      child: Container(
                        width: 350.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.sp),
                          color: Colors.blue,
                        ),
                        child: TextButton(
                          onPressed: () async {
                            final orderProvider = ref
                                .read(IDProvider.notifier)
                                .update(
                                    (state) => widget.DetilsData.id.toString());
                            final p = await ref
                                .read(remoteOrdersRepository)
                                .getStartMission(
                                    widget.DetilsData.id.toString());

                            print("hhhhhhhhhhhhh: $orderProvider");

                            print("jjjjjjjjjjjjjjj1111 ${p.id}");

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OrderDetailsScreen(
                                          DetilsData: p,
                                        )));
                          },
                          child: Text(
                            t.locationUpdateRequest,
                            style: TextStyle(
                                color: ColorsApp.white, fontSize: 18.sp),
                          ),
                        ),
                      ),
                    ),
                    Divider(color: Colors.grey),
                  ],
                  Card(
                    color: Colors.white,
                    margin: EdgeInsets.all(7.0.sp),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 105.w, vertical: 10.h),
                      child: Column(
                        children: [
                          Text(
                            t.theAmountToBeReceived,
                            style:
                                TextStyle(fontSize: 10.sp, color: Colors.grey),
                          ),
                          SizedBox(height: 3.h),
                          Text(
                            '${widget.DetilsData.cod.toString()} SAR',
                            style: TextStyle(
                                fontSize: 24.sp, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0.sp),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isShow = !isShow;
                        });
                      },
                      child: Row(
                        children: [
                          Text(
                            t.additionalDetails,
                            style: TextStyle(fontSize: 11.sp),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.grey,
                            ),
                          ),
                          Icon(isShow
                              ? Icons.arrow_drop_down_outlined
                              : Icons.arrow_drop_up_outlined),
                        ],
                      ),
                    ),
                  ),
                  isShow
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25.w),
                              child: Text(
                                t.tripInformation,
                                textAlign: TextAlign.end,
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ),

                            // Additional Details Card
                            Card(
                              color: ColorsApp.white,
                              margin: EdgeInsets.all(16.0.sp),
                              child: Padding(
                                padding: EdgeInsets.all(16.0.sp),
                                child: Column(
                                  // crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    _buildRowItem(
                                        context,
                                        widget.DetilsData.destinationAddress
                                            .toString(),
                                        '${t.to + widget.DetilsData.destinationName} ',
                                        Icon(Icons.phone),
                                        Colors.blue,
                                        widget.DetilsData.destinationNumberPhone
                                            .toString()),
                                    _buildRowItem(
                                        context,
                                        widget.DetilsData.sourceAddress
                                            .toString(),
                                        '${t.from + widget.DetilsData.sourceName}',
                                        Icon(Icons.phone),
                                        Colors.green,
                                        widget.DetilsData.sourceNumberPhone),
                                    // Divider(height: 32),
                                    _buildInfoItem(
                                        context,
                                        t.deliveryZone,
                                        widget.DetilsData.deliveryZone,
                                        Icons.local_shipping,
                                        Colors.yellow,
                                        '${widget.DetilsData.cod}SAR',
                                        true,
                                        0,
                                        true,
                                        SizedBox(
                                          height: 0,
                                        )),
                                    _buildInfoItem(
                                        context,
                                        t.dateCreated,
                                        widget.DetilsData.assignmentDate
                                            .toString(),
                                        Icons.calendar_month_sharp,
                                        Colors.purple,
                                        '',
                                        false,
                                        0,
                                        true,
                                        SizedBox(
                                          height: 0,
                                        )),
                                    _buildInfoItem(
                                        context,
                                        t.thePeriodOfTimeToCarryTheShipment,
                                        ' في أقرب وقت ممكن',
                                        Icons.access_time,
                                        Colors.orange,
                                        '',
                                        false,
                                        0,
                                        true,
                                        SizedBox(
                                          height: 0,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30.w),
                              child: Text(
                                t.packageInformation,
                                textAlign: TextAlign.end,
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ),
                            Card(
                              color: ColorsApp.white,
                              margin: EdgeInsets.all(16.0.sp),
                              child: Padding(
                                padding: EdgeInsets.all(16.0.sp),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    _buildInfoItem(
                                        context,
                                        t.packageType,
                                        widget.DetilsData.containerType
                                            .toString(),
                                        Icons.assignment,
                                        Colors.yellow,
                                        '',
                                        false,
                                        0,
                                        true,
                                        SizedBox(
                                          height: 0,
                                        )),
                                    _buildInfoItem(
                                        context,
                                        t.Weight,
                                        widget.DetilsData.weight,
                                        Icons.line_weight,
                                        Colors.green,
                                        '',
                                        false,
                                        0,
                                        true,
                                        SizedBox(
                                          height: 0,
                                        )),
                                    _buildInfoItem(
                                        context,
                                        t.Quantity,
                                        widget.DetilsData.quantity,
                                        Icons.numbers,
                                        Colors.red,
                                        '',
                                        false,
                                        0,
                                        true,
                                        SizedBox(
                                          height: 0,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30.w),
                              child: Text(
                                t.paymentInformation,
                                textAlign: TextAlign.end,
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ),
                            Card(
                              color: ColorsApp.white,
                              margin: EdgeInsets.all(16.0.sp),
                              child: Padding(
                                padding: EdgeInsets.all(16.0.sp),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildInfoItem(
                                        context,
                                        t.PaymentType,
                                        t.monetary,
                                        Icons.attach_money,
                                        Colors.green,
                                        '',
                                        false,
                                        0,
                                        true,
                                        SizedBox(
                                          height: 0,
                                        )),
                                    if (false)
                                      _buildInfoItem(
                                          context,
                                          t.PaymentWasMadeVia,
                                          ' ',
                                          Icons.person,
                                          Colors.grey,
                                          '',
                                          false,
                                          0,
                                          true,
                                          SizedBox(
                                            height: 0,
                                          )),
                                    _buildInfoItem(
                                        context,
                                        t.ServiceCost,
                                        ' ${widget.DetilsData.cod} SAR',
                                        Icons.money_rounded,
                                        Colors.lightGreen,
                                        t.paid,
                                        false,
                                        1,
                                        //TODO Firas : once jhiad add isPaid as bool use it here!
                                        true,
                                        SizedBox(
                                          height: 0,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 100.h,
                            )
                          ],
                        )
                      : SizedBox(
                          height: 0,
                        ),
                ],
              ),
            ),
            if (orderDetails?.status == "assigned_to_driver" ||
                orderDetails?.status == "dispatched")
              startRejectButtons(),
            if (orderDetails?.status == "out_for_pickup" ||
                orderDetails?.status == "out_for_delivery")
              arrivedRejectButton(),
            if (orderDetails?.status == "arrived" ||
                orderDetails?.status == "arrived_at_delivery_address")
              validateRejectButton(),
            // if (ref.watch(orderDetailsScreenLoaderProvider))
            //   ModalBarrier(
            //     dismissible: false, // Prevent dismissing by tapping outside
            //     color: Colors.black54,
            //   ),
            // if (ref.watch(orderDetailsScreenLoaderProvider))
            //   Center(
            //     child: CircularProgressIndicator(),
            //   ),
          ],
        ),
      ),
    );
  }

  Widget _buildRowItem(BuildContext context, String address, String name,
      Icon icon, Color avatarColor, String number) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.all(3.0.sp),
          child: CircleAvatar(
            backgroundColor: avatarColor,
            child: Text(name.substring(0, 1),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(color: Colors.white)),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
              Text(address, style: TextStyle(fontSize: 14.sp)),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        IconButton(
          icon: icon,
          color: ColorsApp.black,
          onPressed: () => callNumber(number),
        ),
      ],
    );
  }

  Widget _buildInfoItem(
      BuildContext context,
      String title,
      String value,
      IconData icon,
      Color iconColor,
      String cash,
      bool isPaid,
      int cashColor,
      bool isValue,
      Widget widgetValue) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.0.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              CircleAvatar(
                child: Icon(icon, color: iconColor),
                backgroundColor: Colors.grey[350],
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 55.0.w),
                        child: Text(title,
                            style: TextStyle(
                                fontSize: 15.2.sp, color: Colors.grey)),
                      ),
                      SizedBox(width: 8.w),
                    ],
                  ),
                  isValue
                      ? Padding(
                          padding: EdgeInsets.only(right: 55.0.w, left: 55.0.w),
                          child: Container(
                            child: Text(value,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold)),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 60.0.w),
                          child: widgetValue,
                        ),
                ],
              ),
            ],
          ),
          if (isPaid)
            Container(
              width: 65.w,
              child: Text(cash,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: cashColor == 1 ? Colors.green : Colors.black)),
            ),
        ],
      ),
    );
  }

  Future<void> _launchMapsUrl() async {
    final lat = 33.509883; // إحداثيات الموقع
    final lng = 36.305231; // إحداثيات الموقع
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void callNumber(String phoneNumber) async {
    if (await canLaunch("tel:$phoneNumber")) {
      await launch("tel:$phoneNumber");
    } else {
      throw "Unable to launch phone app";
    }
  }

  void openWhatsApp(String WhatsappNumber) async {
    String url = "https://wa.me/+966$WhatsappNumber";
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw "Unable to open WhatsApp";
    }
  }

  Future<void> refresh() async {
    ref.read(orderDetailsScreenLoaderProvider.notifier).state = true;
    await ref.read(singleOrderProvider.notifier).getOrder(widget.DetilsData.id);
    ref.read(orderDetailsScreenLoaderProvider.notifier).state = false;
  }

  Widget startRejectButtons() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 80.0.h),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      try {
                        ref
                            .read(orderDetailsScreenLoaderProvider.notifier)
                            .state = true;
                        //Start mission
                        await ref
                            .read(remoteOrdersRepository)
                            .getStartMission(widget.DetilsData.id.toString());

                        ref
                            .read(IDProvider.notifier)
                            .update((state) => widget.DetilsData.id.toString());

                        await refresh();

                        ref
                            .read(orderDetailsScreenLoaderProvider.notifier)
                            .state = false;
                      } catch (e) {
                        ref
                            .read(orderDetailsScreenLoaderProvider.notifier)
                            .state = false;
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      height: 50.h,
                      color: Color(0xFFF5DB506),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          t.start,
                          style: TextStyle(color: ColorsApp.white),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      var ReasonsRejection = await ApiService()
                          .getReasonsRejection(Endpoints.ReasonsRejection, ref);
                      // Assuming the response is a list of JSON objects
                      // final ReasonsRejectionStatusEntity optionss =
                      //     await ReasonsRejectionStatusEntity.fromJson(
                      //         ReasonsRejection);
                      List<ReasonsRejectionStatusEntity> entities =
                          ReasonsRejection.map<ReasonsRejectionStatusEntity>(
                              (json) => ReasonsRejectionStatusEntity.fromJson(
                                  json)).toList();

                      // Convert the list of entities to a list of maps
                      List<Map<String, dynamic>> options =
                          ReasonsRejectionStatusEntity.toJsonList(entities);

                      print(options);
                      // Convert the list of entities to a list of maps

                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return MyBottomNavigationBar2(context, ref,
                                "${widget.DetilsData.id.toString()}", options);
                          });
                    },
                    child: Container(
                      height: 50.h,
                      color: Colors.red,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          t.reject,
                          style: TextStyle(color: ColorsApp.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget arrivedRejectButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 80.0.h),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      try {
                        ref
                            .read(orderDetailsScreenLoaderProvider.notifier)
                            .state = true;

                        await ref
                            .read(remoteOrdersRepository)
                            .postArrived(widget.DetilsData.id);

                        await refresh();

                        ref
                            .read(orderDetailsScreenLoaderProvider.notifier)
                            .state = false;
                      } catch (e) {
                        e;
                        ref
                            .read(orderDetailsScreenLoaderProvider.notifier)
                            .state = false;
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      height: 50.h,
                      color: Color(0xFFF5DB506),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          t.arrived,
                          style: TextStyle(color: ColorsApp.white),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      var ReasonsRejection = await ApiService()
                          .getReasonsRejection(Endpoints.ReasonsRejection, ref);
                      // Assuming the response is a list of JSON objects
                      // final ReasonsRejectionStatusEntity optionss =
                      //     await ReasonsRejectionStatusEntity.fromJson(
                      //         ReasonsRejection);
                      List<ReasonsRejectionStatusEntity> entities =
                          ReasonsRejection.map<ReasonsRejectionStatusEntity>(
                              (json) => ReasonsRejectionStatusEntity.fromJson(
                                  json)).toList();

                      // Convert the list of entities to a list of maps
                      List<Map<String, dynamic>> options =
                          ReasonsRejectionStatusEntity.toJsonList(entities);

                      print(options);
                      // Convert the list of entities to a list of maps

                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return MyBottomNavigationBar2(context, ref,
                                "${widget.DetilsData.id.toString()}", options);
                          });
                    },
                    child: Container(
                      height: 50.h,
                      color: Color(0xFFFFF4545),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Reject",
                          style: TextStyle(color: ColorsApp.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget validateRejectButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 80.0.h),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      try {
                        ref
                            .read(orderDetailsScreenLoaderProvider.notifier)
                            .state = true;
                        // _saveSignature;
                        // if (widget.DetilsData.validationDateStep1 == 'null') {

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ValidateOrderScreen(
                                title: widget.DetilsData.validationDateStep1 ==
                                        null
                                    ? "Validate Pickup"
                                    : "Validate Delivery",
                                stepNumber:
                                    widget.DetilsData.validationDateStep1 ==
                                            null
                                        ? "1"
                                        : "2",
                                requestId: widget.DetilsData.id.toString(),
                              );
                            },
                          ),
                        );
                        ref
                            .read(orderDetailsScreenLoaderProvider.notifier)
                            .state = false;
                      } catch (e) {
                        ref
                            .read(orderDetailsScreenLoaderProvider.notifier)
                            .state = false;
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      height: 50.h,
                      color: Color(0xFFF5DB506),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          t.validate,
                          style: TextStyle(color: ColorsApp.white),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      var ReasonsRejection = await ApiService()
                          .getReasonsRejection(Endpoints.ReasonsRejection, ref);
                      // Assuming the response is a list of JSON objects
                      // final ReasonsRejectionStatusEntity optionss =
                      //     await ReasonsRejectionStatusEntity.fromJson(
                      //         ReasonsRejection);
                      List<ReasonsRejectionStatusEntity> entities =
                          ReasonsRejection.map<ReasonsRejectionStatusEntity>(
                              (json) => ReasonsRejectionStatusEntity.fromJson(
                                  json)).toList();

                      // Convert the list of entities to a list of maps
                      List<Map<String, dynamic>> options =
                          ReasonsRejectionStatusEntity.toJsonList(entities);

                      print(options);
                      // Convert the list of entities to a list of maps

                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return MyBottomNavigationBar2(context, ref,
                                "${widget.DetilsData.id.toString()}", options);
                          });
                    },
                    child: Container(
                      height: 50.h,
                      color: Color(0xFFFFF4545),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Reject",
                          style: TextStyle(color: ColorsApp.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
