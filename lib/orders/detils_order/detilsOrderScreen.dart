// import 'dart:io';
// import 'dart:typed_data';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter_map/plugin_api.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:logistics/constants/colors.dart';
// import 'package:logistics/constants/dio.dart';
// import 'package:logistics/constants/endpoints.dart';
// import 'package:logistics/constants/images.dart';
// import 'package:logistics/i18n/strings.g.dart';
// import 'package:logistics/orders/detils_order/bottom_navigationBar.dart';
// import 'package:logistics/orders/entity/detils_entity.dart';
// import 'package:logistics/orders/entity/reasons_rejection_entity.dart';
// import 'package:logistics/orders/providers/orders_provider.dart';
// import 'package:logistics/orders/recipient_signature/RecipientSignatureScreen.dart';
// import 'package:logistics/orders/repository/remote_orders_repository.dart';
// import 'package:logistics/orders/senders_signature/senders_signature_screen.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:signature/signature.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class DetailsOrderScreen extends ConsumerStatefulWidget {
//   final DetilsEntity DetilsData;
//   const DetailsOrderScreen({Key? key, required this.DetilsData})
//       : super(key: key);
//
//   @override
//   ConsumerState<DetailsOrderScreen> createState() => _detailsOrderScreenState();
// }
//
// class _detailsOrderScreenState extends ConsumerState<DetailsOrderScreen> {
//   late SignatureController _controllerSignature;
//   File? _image;
//   late bool isShow = true;
//   @override
//   void initState() {
//     // _initState();
//     super.initState();
//     // _loadingPro();
//     _controllerSignature = SignatureController(
//       penStrokeWidth: 5,
//       penColor: Colors.black,
//       exportBackgroundColor: Colors.white,
//     );
//   }
//
//   // Future<void> _initState() async {
//   //   final orderProvider =
//   //       ref.read(IDProvider.notifier).update((state) => widget.ID.toString());
//   //   final p = await ref.read(remoteOrdersRepository).getStartMission(widget.ID);
//   //   print("hhhhhhhhhhhhh: $orderProvider");
//   //
//   //   print("jjjjjjjjjjjjjjj1111 ${p.id}");
//   // }
//
//   @override
//   void dispose() {
//     _controllerSignature.dispose();
//
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     //final detilsProvider = ref.read(orderDetilsProvider);
//
//     return Scaffold(
//       backgroundColor: ColorsApp.backgroundColor,
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             child: Column(
//               // crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 Text("Details"),
//                 Container(
//                   color: Colors.grey[300],
//                   child: Column(
//                     children: [
//                       Stack(
//                         children: [
//                           Container(
//                             height: 300.h,
//                             child: FlutterMap(
//                               options: MapOptions(
//                                 center: LatLng(
//                                     24.778810, 46.730354), // إحداثيات الموقع
//                                 zoom: 14.0.sp,
//                               ),
//                               children: [
//                                 TileLayer(
//                                   urlTemplate:
//                                       'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//                                   subdomains: ['a', 'b', 'c'],
//                                 ),
//                                 MarkerLayer(
//                                   markers: [
//                                     Marker(
//                                       width: 80.0.w,
//                                       height: 80.0.h,
//                                       point: LatLng(24.778810,
//                                           46.730354), // إحداثيات الموقع
//                                       builder: (ctx) => Icon(
//                                         Icons.location_on,
//                                         color: Colors.red,
//                                         size: 40.sp,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Positioned.fill(
//                             child: Material(
//                               color: Color(0x629D9D9D),
//                               child: InkWell(
//                                 onTap: _launchMapsUrl,
//                               ),
//                             ),
//                           ),
//                           Center(
//                             child: Padding(
//                               padding: EdgeInsets.only(top: 60.sp),
//                               child: Column(
//                                 children: [
//                                   CircleAvatar(
//                                     backgroundColor: Colors.red,
//                                     child: Text(
//                                       widget.DetilsData.destinationName
//                                           .substring(0, 1),
//                                       style: TextStyle(color: ColorsApp.white),
//                                     ),
//                                   ),
//                                   Text(
//                                     widget.DetilsData.destinationName
//                                         .toString(), // 'test',
//                                     overflow: TextOverflow.ellipsis,
//                                     maxLines: 1,
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                   Text(
//                                     overflow: TextOverflow.ellipsis,
//                                     maxLines: 2,
//                                     widget.DetilsData.destinationAddress
//                                         .toString(),
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                   SizedBox(
//                                     height: 80.h,
//                                   ),
//                                   Text(
//                                     '${t.orderNumber + widget.DetilsData.barcode} ',
//                                     overflow: TextOverflow.ellipsis,
//                                     maxLines: 1,
//                                     style: TextStyle(
//                                         fontSize: 23.sp,
//                                         color: ColorsApp.white,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.only(top: 28.sp),
//                                     child: Container(
//                                       color: ColorsApp.backgroundColor,
//                                       width: double.infinity,
//                                       padding: EdgeInsets.all(8.7.sp),
//                                       child: Text(''
//                                           // t.accept,
//                                           // textAlign: TextAlign.start,
//                                           // style: TextStyle(
//                                           //     color: Colors.white,
//                                           //     fontSize: 18.sp),
//                                           ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(top: 250.sp),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Padding(
//                                       padding: EdgeInsets.all(10.0.sp),
//                                       child: CircleAvatar(
//                                         backgroundColor: Colors.green,
//                                         child: IconButton(
//                                           icon: Icon(Icons.phone,
//                                               color: ColorsApp.white),
//                                           onPressed: () {
//                                             callNumber(widget.DetilsData
//                                                 .destinationNumberPhone
//                                                 .toString());
//                                           },
//                                         ),
//                                         maxRadius: 25.sp,
//                                         minRadius: 25.sp,
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.all(8.0.sp),
//                                       child: InkWell(
//                                         onTap: () => openWhatsApp(widget
//                                             .DetilsData.destinationNumberPhone
//                                             .toString()),
//                                         child: CircleAvatar(
//                                           backgroundColor: Colors.white,
//                                           child: Image.asset(
//                                             ImageAssets.whatsapp,
//                                             height: 25.h,
//                                             width: 25.w,
//                                           ),
//                                           maxRadius: 25.sp,
//                                           minRadius: 25.sp,
//                                         ),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.all(8.0.sp),
//                                       child: CircleAvatar(
//                                         backgroundColor: Colors.white,
//                                         child: IconButton(
//                                           icon: Icon(Icons.cloud_download,
//                                               color: Colors.grey),
//                                           onPressed: () {
//                                             //   downloadAndConvertImageToPDF();
//                                           },
//                                         ),
//                                         maxRadius: 25.sp,
//                                         minRadius: 25.sp,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(5.0.sp),
//                   child: Container(
//                     width: 350.w,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8.sp),
//                       color: Colors.blue,
//                     ),
//                     child: TextButton(
//                       onPressed: () async {
//                         final orderProvider = ref
//                             .read(IDProvider.notifier)
//                             .update((state) => widget.DetilsData.id.toString());
//                         final p = await ref
//                             .read(remoteOrdersRepository)
//                             .getStartMission(widget.DetilsData.id.toString());
//
//                         print("hhhhhhhhhhhhh: $orderProvider");
//
//                         print("jjjjjjjjjjjjjjj1111 ${p.id}");
//
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => DetailsOrderScreen(
//                                       DetilsData: p,
//                                     )));
//                       },
//                       child: Text(
//                         t.locationUpdateRequest,
//                         style:
//                             TextStyle(color: ColorsApp.white, fontSize: 18.sp),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Divider(color: Colors.grey),
//                 Card(
//                   margin: EdgeInsets.all(7.0.sp),
//                   child: Padding(
//                     padding:
//                         EdgeInsets.symmetric(horizontal: 105.w, vertical: 10.h),
//                     child: Column(
//                       children: [
//                         Text(
//                           t.theAmountToBeReceived,
//                           style: TextStyle(fontSize: 10.sp, color: Colors.grey),
//                         ),
//                         SizedBox(height: 3.h),
//                         Text(
//                           '${widget.DetilsData.cod.toString()}SAR',
//                           style: TextStyle(
//                               fontSize: 24.sp, fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(8.0.sp),
//                   child: InkWell(
//                     onTap: () {
//                       setState(() {
//                         isShow = !isShow;
//                       });
//                     },
//                     child: Row(
//                       children: [
//                         Text(
//                           t.additionalDetails,
//                           style: TextStyle(fontSize: 11.sp),
//                         ),
//                         Expanded(
//                           child: Divider(
//                             color: Colors.grey,
//                           ),
//                         ),
//                         Icon(isShow
//                             ? Icons.arrow_drop_down_outlined
//                             : Icons.arrow_drop_up_outlined),
//                       ],
//                     ),
//                   ),
//                 ),
//                 isShow
//                     ? Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 25.w),
//                             child: Text(
//                               t.tripInformation,
//                               textAlign: TextAlign.end,
//                               style: TextStyle(color: Colors.grey[600]),
//                             ),
//                           ),
//
//                           // Additional Details Card
//                           Card(
//                             color: ColorsApp.white,
//                             margin: EdgeInsets.all(16.0.sp),
//                             child: Padding(
//                               padding: EdgeInsets.all(16.0.sp),
//                               child: Column(
//                                 // crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: [
//                                   _buildRowItem(
//                                       context,
//                                       widget.DetilsData.destinationAddress
//                                           .toString(),
//                                       '${t.to + widget.DetilsData.destinationName} ',
//                                       Icon(Icons.phone),
//                                       Colors.blue,
//                                       widget.DetilsData.destinationNumberPhone
//                                           .toString()),
//                                   _buildRowItem(
//                                       context,
//                                       widget.DetilsData.sourceAddress
//                                           .toString(),
//                                       '${t.from + widget.DetilsData.sourceName}',
//                                       Icon(Icons.phone),
//                                       Colors.green,
//                                       widget.DetilsData.sourceNumberPhone),
//                                   // Divider(height: 32),
//                                   _buildInfoItem(
//                                       context,
//                                       t.serviceType,
//                                       'Express Delivery',
//                                       Icons.local_shipping,
//                                       Colors.yellow,
//                                       '${widget.DetilsData.cod}SAR',
//                                       true,
//                                       0,
//                                       true,
//                                       SizedBox(
//                                         height: 0,
//                                       )),
//                                   _buildInfoItem(
//                                       context,
//                                       t.dateCreated,
//                                       widget.DetilsData.assignmentDate
//                                           .toString(),
//                                       Icons.calendar_month_sharp,
//                                       Colors.purple,
//                                       '',
//                                       false,
//                                       0,
//                                       true,
//                                       SizedBox(
//                                         height: 0,
//                                       )),
//                                   _buildInfoItem(
//                                       context,
//                                       t.thePeriodOfTimeToCarryTheShipment,
//                                       ' في أقرب وقت ممكن',
//                                       Icons.access_time,
//                                       Colors.orange,
//                                       '',
//                                       false,
//                                       0,
//                                       true,
//                                       SizedBox(
//                                         height: 0,
//                                       )),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 10.h),
//
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 30.w),
//                             child: Text(
//                               t.packageInformation,
//                               textAlign: TextAlign.end,
//                               style: TextStyle(color: Colors.grey[600]),
//                             ),
//                           ),
//                           Card(
//                             color: ColorsApp.white,
//                             margin: EdgeInsets.all(16.0.sp),
//                             child: Padding(
//                               padding: EdgeInsets.all(16.0.sp),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: [
//                                   _buildInfoItem(
//                                       context,
//                                       t.packageType,
//                                       widget.DetilsData.containerType
//                                           .toString(),
//                                       Icons.assignment,
//                                       Colors.yellow,
//                                       '',
//                                       false,
//                                       0,
//                                       true,
//                                       SizedBox(
//                                         height: 0,
//                                       )),
//                                   _buildInfoItem(
//                                       context,
//                                       t.description,
//                                       ' ',
//                                       Icons.edit,
//                                       Colors.green,
//                                       '',
//                                       false,
//                                       0,
//                                       true,
//                                       SizedBox(
//                                         height: 0,
//                                       )),
//                                   // _buildInfoItem(
//                                   //     context,
//                                   //     t.PackagePhoto,
//                                   //     ' لايوجد',
//                                   //     Icons.image,
//                                   //     Colors.purple,
//                                   //     '',
//                                   //     false,
//                                   //     0,
//                                   //     false,
//                                   //     Image.network(
//                                   //         width: 160.w,
//                                   //         height: 100.h,
//                                   //         widget.DetilsData.validation1Image
//                                   //                     .toString() ==
//                                   //                 'null'
//                                   //             ? 'https://www.syncfusion.com/blogs/wp-content/uploads/2021/04/How-to-perform-text-search-over-the-PDF-document-using-Flutter-PDF-Viewer.png'
//                                   //             : widget
//                                   //                 .DetilsData.validation1Image
//                                   //                 .toString())),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 10.h),
//                           //
//                           // Padding(
//                           //   padding: EdgeInsets.symmetric(horizontal: 30.w),
//                           //   child: Text(
//                           //     t.proofOfDelivery,
//                           //     textAlign: TextAlign.end,
//                           //     style: TextStyle(color: Colors.grey[600]),
//                           //   ),
//                           // ),
//                           // Card(
//                           //   color: ColorsApp.white,
//                           //   margin: EdgeInsets.all(16.0.sp),
//                           //   child: Padding(
//                           //     padding: EdgeInsets.all(16.0.sp),
//                           //     child: Column(
//                           //       crossAxisAlignment: CrossAxisAlignment.start,
//                           //       children: [
//                           //         _buildInfoItem(
//                           //             context,
//                           //             t.NameOfAddresseeRecipient,
//                           //             widget.DetilsData.sourceName.toString(),
//                           //             Icons.person,
//                           //             Colors.grey,
//                           //             '',
//                           //             false,
//                           //             0,
//                           //             true,
//                           //             SizedBox(
//                           //               height: 0,
//                           //             )),
//                           //         _buildInfoItem(
//                           //           context,
//                           //           t.ProofOfTheRecipientsIdentity,
//                           //           'test ',
//                           //           Icons.badge_sharp,
//                           //           Colors.blueAccent,
//                           //           '',
//                           //           false,
//                           //           0,
//                           //           false,
//                           //           Column(
//                           //             crossAxisAlignment:
//                           //                 CrossAxisAlignment.center,
//                           //             children: [
//                           //               if (_image != null)
//                           //                 Image.file(
//                           //                   _image!,
//                           //                   height: 100.h,
//                           //                   width: 160.w,
//                           //                 ),
//                           //               SizedBox(height: 16.h),
//                           //               ElevatedButton(
//                           //                 style: ButtonStyle(
//                           //                   backgroundColor:
//                           //                       MaterialStateProperty.all<
//                           //                               Color>(
//                           //                           ColorsApp.backgroundColor),
//                           //                 ),
//                           //                 onPressed: () =>
//                           //                     _pickImage(ImageSource.camera),
//                           //                 child: Text(
//                           //                   t.openCamera,
//                           //                   style: TextStyle(
//                           //                       color: ColorsApp.black),
//                           //                 ),
//                           //               ),
//                           //             ],
//                           //           ),
//                           //         ),
//                           //         _buildInfoItem(
//                           //             context,
//                           //             t.TheRecipientsSignature,
//                           //             ' لايوجد',
//                           //             Icons.edit,
//                           //             Colors.red,
//                           //             '',
//                           //             false,
//                           //             0,
//                           //             false,
//                           //             Column(
//                           //               crossAxisAlignment:
//                           //                   CrossAxisAlignment.start,
//                           //               children: [
//                           //                 SizedBox(height: 10.h),
//                           //                 Signature(
//                           //                   controller: _controllerSignature,
//                           //                   height: 100.h,
//                           //                   width: 160.w,
//                           //                   backgroundColor: Colors.grey[300]!,
//                           //                 ),
//                           //                 SizedBox(height: 16.h),
//                           //                 ElevatedButton(
//                           //                   style: ButtonStyle(
//                           //                     backgroundColor:
//                           //                         MaterialStateProperty
//                           //                             .all<Color>(ColorsApp
//                           //                                 .backgroundColor),
//                           //                   ),
//                           //                   onPressed: () {
//                           //                     setState(() {
//                           //                       _controllerSignature.clear();
//                           //                     });
//                           //                   },
//                           //                   child: Text(
//                           //                     t.clear,
//                           //                     style: TextStyle(
//                           //                         color: ColorsApp.black),
//                           //                   ),
//                           //                 ),
//                           //               ],
//                           //             )),
//                           //         _buildInfoItem(
//                           //             context,
//                           //             t.ConnectionStatus,
//                           //             widget.DetilsData.type.toString(),
//                           //             Icons.assignment_turned_in_rounded,
//                           //             Colors.green,
//                           //             '',
//                           //             false,
//                           //             0,
//                           //             true,
//                           //             SizedBox(
//                           //               height: 0,
//                           //             )),
//                           //       ],
//                           //     ),
//                           //   ),
//                           // ),
//                           //
//                           // SizedBox(height: 10.h),
//
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 30.w),
//                             child: Text(
//                               t.paymentInformation,
//                               textAlign: TextAlign.end,
//                               style: TextStyle(color: Colors.grey[600]),
//                             ),
//                           ),
//                           Card(
//                             color: ColorsApp.white,
//                             margin: EdgeInsets.all(16.0.sp),
//                             child: Padding(
//                               padding: EdgeInsets.all(16.0.sp),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   _buildInfoItem(
//                                       context,
//                                       t.PaymentType,
//                                       t.monetary,
//                                       Icons.attach_money,
//                                       Colors.green,
//                                       '',
//                                       false,
//                                       0,
//                                       true,
//                                       SizedBox(
//                                         height: 0,
//                                       )),
//                                   _buildInfoItem(
//                                       context,
//                                       t.PaymentWasMadeVia,
//                                       ' ',
//                                       Icons.person,
//                                       Colors.grey,
//                                       '',
//                                       false,
//                                       0,
//                                       true,
//                                       SizedBox(
//                                         height: 0,
//                                       )),
//                                   _buildInfoItem(
//                                       context,
//                                       t.ServiceCost,
//                                       ' ${widget.DetilsData.cod}',
//                                       Icons.money_rounded,
//                                       Colors.lightGreen,
//                                       t.paid,
//                                       true,
//                                       1,
//                                       true,
//                                       SizedBox(
//                                         height: 0,
//                                       )),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 100.h,
//                           )
//                         ],
//                       )
//                     : SizedBox(
//                         height: 0,
//                       ),
//               ],
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Stack(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(top: 80.0.h),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: InkWell(
//                           onTap: () async {
//                             var ReasonsRejection = await ApiService()
//                                 .getReasonsRejection(
//                                     Endpoints.ReasonsRejection, ref);
//                             // Assuming the response is a list of JSON objects
//                             final ReasonsRejectionStatusEntity options =
//                                 await ReasonsRejectionStatusEntity.fromJson(
//                                     ReasonsRejection);
//
//                             showModalBottomSheet(
//                                 context: context,
//                                 builder: (BuildContext context) {
//                                   return MyBottomNavigationBar2(
//                                       context,
//                                       ref,
//                                       "${widget.DetilsData.id.toString()}",
//                                       options);
//                                 });
//                           },
//                           child: Container(
//                             height: 50.h,
//                             color: Colors.red,
//                             child: Align(
//                               alignment: Alignment.center,
//                               child: Text(
//                                 t.cancel,
//                                 style: TextStyle(color: ColorsApp.white),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: InkWell(
//                           onTap: () async {
//                             _saveSignature;
//                             final String reaspons = await ApiService()
//                                 .postArrived(
//                                     ref, widget.DetilsData.id.toString());
//                             if (widget.DetilsData.validationDateStep1 ==
//                                     'null' &&
//                                 reaspons == '200') {
//                               Navigator.push(context,
//                                   MaterialPageRoute(builder: (context) {
//                                 return ValidateOrderScreen(
//                                   title: "",
//                                   requestId: widget.DetilsData.id.toString(),
//                                 );
//                               }));
//                             } else {
//                               Navigator.push(context,
//                                   MaterialPageRoute(builder: (context) {
//                                 return RecipientSignatureScreen(
//                                   requestId: widget.DetilsData.id.toString(),
//                                 );
//                               }));
//                             }
//                           },
//                           child: Container(
//                             height: 200.h,
//                             color: Colors.orangeAccent,
//                             child: Align(
//                               alignment: Alignment.center,
//                               child: Text(
//                                 t.InTheShippingStage,
//                                 style: TextStyle(color: ColorsApp.white),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Stack(
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.only(top: 40.0.h),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: InkWell(
//                               onTap: () {
//                                 _launchMapsUrl;
//                               },
//                               child: Container(
//                                 height: 40.h,
//                                 color: ColorsApp.white,
//                                 child: Align(
//                                   alignment: Alignment.center,
//                                   child: Text(
//                                     t.RequestADeliveryLocation,
//                                     style: TextStyle(
//                                         color: Colors.indigo, fontSize: 15.sp),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(bottom: 35.0.h),
//                       child: Container(
//                         color: Colors.transparent,
//                         height: 30.h,
//                       ),
//                     ),
//                     PositionedDirectional(
//                       start: 280.sp,
//                       top: 12.sp,
//                       child: Container(
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.2),
//                               spreadRadius: 5.sp,
//                               blurRadius: 7.sp,
//                               offset: Offset(0, 3),
//                             ),
//                           ],
//                         ),
//                         child: CircleAvatar(
//                           radius: 30.sp,
//                           backgroundColor: ColorsApp.white,
//                           child: IconButton(
//                             onPressed: () {
//                               _launchMapsUrl;
//                               setState(() {
//                                 //LocaleSettings.setLocale(AppLocale.en);
//                               });
//                             },
//                             icon: Icon(
//                               Icons.details,
//                               color: Colors.blue,
//                               size: 30.sp,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildRowItem(BuildContext context, String address, String name,
//       Icon icon, Color avatarColor, String number) {
//     return Row(
//       children: [
//         Padding(
//           padding: EdgeInsets.all(3.0.sp),
//           child: CircleAvatar(
//             backgroundColor: avatarColor,
//             child: Text(name.substring(0, 1),
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 1,
//                 style: TextStyle(color: Colors.white)),
//           ),
//         ),
//         SizedBox(width: 8.w),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(name,
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 2,
//                   style:
//                       TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
//               Text(address, style: TextStyle(fontSize: 14.sp)),
//             ],
//           ),
//         ),
//         SizedBox(width: 8.w),
//         IconButton(
//           icon: icon,
//           color: ColorsApp.black,
//           onPressed: () => callNumber(number),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildInfoItem(
//       BuildContext context,
//       String title,
//       String value,
//       IconData icon,
//       Color iconColor,
//       String cash,
//       bool isCash,
//       int cashColor,
//       bool isValue,
//       Widget widgetValue) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 3.0.w, vertical: 8.h),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Stack(
//             children: [
//               CircleAvatar(
//                 child: Icon(icon, color: iconColor),
//                 backgroundColor: Colors.grey[350],
//               ),
//               SizedBox(width: 8.w),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 55.0.w),
//                         child: Text(title,
//                             style: TextStyle(
//                                 fontSize: 15.2.sp, color: Colors.grey)),
//                       ),
//                       SizedBox(width: 8.w),
//                     ],
//                   ),
//                   isValue
//                       ? Padding(
//                           padding: EdgeInsets.only(right: 55.0.w, left: 55.0.w),
//                           child: Container(
//                             child: Text(value,
//                                 overflow: TextOverflow.ellipsis,
//                                 maxLines: 1,
//                                 style: TextStyle(
//                                     fontSize: 12.sp,
//                                     fontWeight: FontWeight.bold)),
//                           ),
//                         )
//                       : Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 60.0.w),
//                           child: widgetValue,
//                         ),
//                 ],
//               ),
//             ],
//           ),
//           isCash
//               ? Container(
//                   width: 65.w,
//                   child: Text(cash,
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: 1,
//                       style: TextStyle(
//                           fontSize: 12.sp,
//                           fontWeight: FontWeight.bold,
//                           color: cashColor == 1 ? Colors.green : Colors.black)),
//                 )
//               : SizedBox(
//                   width: 0,
//                 ),
//         ],
//       ),
//     );
//   }
//
//   Future<void> _launchMapsUrl() async {
//     final lat = 33.509883; // إحداثيات الموقع
//     final lng = 36.305231; // إحداثيات الموقع
//     final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
//
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
//
//   void callNumber(String phoneNumber) async {
//     if (await canLaunch("tel:$phoneNumber")) {
//       await launch("tel:$phoneNumber");
//     } else {
//       throw "Unable to launch phone app";
//     }
//   }
//
//   void openWhatsApp(String WhatsappNumber) async {
//     String url = "https://wa.me/$WhatsappNumber";
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw "Unable to open WhatsApp";
//     }
//   }
//
//   Future<void> _saveSignature() async {
//     if (await Permission.storage.request().isGranted) {
//       final Uint8List? data = await _controllerSignature.toPngBytes();
//       if (data != null) {
//         final directory = await getExternalStorageDirectory();
//         final file = File('${directory!.path}/signature.png');
//         await file.writeAsBytes(data);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Signature saved to ${file.path}')),
//         );
//         print('${file.path}');
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to save signature')),
//         );
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Storage permission denied')),
//       );
//     }
//   }
//
//   Future<void> _pickImage(ImageSource source) async {
//     final pickedImage = await ImagePicker().pickImage(source: source);
//     if (pickedImage != null) {
//       setState(() {
//         _image = File(pickedImage.path);
//       });
//     }
//   }
// }
