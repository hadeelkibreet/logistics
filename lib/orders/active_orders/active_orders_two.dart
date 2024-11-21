// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:grouped_list/grouped_list.dart';
// import 'package:logistics/constants/colors.dart';
// import 'package:logistics/constants/images.dart';
// import 'package:logistics/drawar/driver_drawar.dart';
// import 'package:logistics/i18n/strings.g.dart';
// import 'package:logistics/logistic_app.dart';
// import 'package:logistics/orders/entity/orders_entity.dart';
// import 'package:logistics/orders/enum/order_type_enum.dart';
// import 'package:logistics/orders/in_way/in_way_screen.dart';
// import 'package:logistics/orders/providers/orders_provider.dart';
// import 'package:logistics/orders/providers/positioned_orders_provider.dart';
// import 'package:logistics/orders/repository/remote_orders_repository.dart';
// import 'package:logistics/orders/widget/card_orders.dart';
// import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
//
// final activeOrderTwoLoaderProvider = StateProvider.autoDispose<bool>(
//   (ref) => false,
// );
//
// class ActiveOrdersTwo extends ConsumerStatefulWidget {
//   const ActiveOrdersTwo({super.key});
//
//   @override
//   _ActiveOrdersTwoState createState() => _ActiveOrdersTwoState();
// }
//
// class _ActiveOrdersTwoState extends ConsumerState<ActiveOrdersTwo> {
//   var getResult = 'QR Code Result';
//   final ScrollController controller = ScrollController();
//   String _selectedOption = 'جميع الطلبات';
//   late bool isdone = false;
//   bool isSearch = false;
//   final TextEditingController _SearchController = TextEditingController();
//   int? _selectedId;
//
//   final ScrollController scrollController = ScrollController();
//
//   @override
//   void initState() {
//     // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//     //   ref.read(ordersProvider.notifier).getOrders(type: OrderType.loading);
//     // });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final orderListProvider = ref.watch(positionedOrdersProvider);
//     final orderNotifier = ref.watch(positionedOrdersProvider.notifier);
//     final isLoading = orderNotifier.isLoading; // Track loading state
//     final error = orderNotifier.error;
//
//     bool _isLoading = false;
//
//     Future<void> _simulateLoading() async {
//       setState(() {
//         _isLoading = true; // Show the loader
//       });
//
//       // Simulate a network request or some processing
//       await Future.delayed(Duration(seconds: 2));
//
//       setState(() {
//         _isLoading = false; // Hide the loader
//       });
//     }
//
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor:
//           orderListProvider.isEmpty ? Colors.white : ColorsApp.backgroundColor,
//       drawer: DriverDrawar(),
//       appBar: myAppBar(context, orderListProvider),
//       body: Stack(
//         children: [
//           Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               if (isLoading) // Show a loading indicator when loading
//                 Center(
//                   child: Padding(
//                     padding: const EdgeInsets.only(top: 20),
//                     child: CircularProgressIndicator(),
//                   ),
//                 )
//               else if (error !=
//                   null) // Show an error message when there is an error
//                 Center(
//                   child: Text(
//                     'Error loading orders: $error',
//                     style: TextStyle(color: Colors.red),
//                   ),
//                 )
//               else if (orderListProvider.isEmpty)
//                 Column(
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.symmetric(vertical: 50.0.sp),
//                       child: Image.asset(
//                         ImageAssets.nullPackage,
//                         fit: BoxFit.fill,
//                       ),
//                     ),
//                     Container(
//                       width: 160.w,
//                       child: ElevatedButton(
//                           onPressed: () {
//                             // ref
//                             //     .read(ordersProvider.notifier)
//                             //     .getOrders(type: ref.read(orderFilterProvider));
//                           },
//                           style: ButtonStyle(
//                             backgroundColor: MaterialStateProperty.all<Color>(
//                                 ColorsApp.backgroundColor),
//                           ),
//                           child: Row(
//                             children: [
//                               const Icon(
//                                 Icons.refresh,
//                                 color: Colors.white,
//                               ),
//                               Text(
//                                 '${t.Reloading}',
//                                 style: TextStyle(
//                                   color: ColorsApp.black,
//                                   fontSize: 16.sp,
//                                 ),
//                               ),
//                             ],
//                           )),
//                     ),
//                   ],
//                 )
//               else ...[
//                 // Padding(
//                 //   padding: const EdgeInsetsDirectional.only(start: 16),
//                 //   child: SizedBox(
//                 //     height: 58,
//                 //     child: ListView.builder(
//                 //       shrinkWrap: true,
//                 //       scrollDirection: Axis.horizontal,
//                 //       itemCount: ref
//                 //               .watch(ordersProvider.notifier)
//                 //               .getOrdersByDestinationName()
//                 //               .length +
//                 //           1,
//                 //       itemBuilder: (context, index) {
//                 //         return GestureDetector(
//                 //           onTap: () {
//                 //             ref.read(selectDestination.notifier).state = index;
//                 //           },
//                 //           child: Padding(
//                 //             padding: const EdgeInsets.only(right: 8.0),
//                 //             child: RawChip(
//                 //               shape: RoundedRectangleBorder(
//                 //                 side: const BorderSide(
//                 //                   width: 0,
//                 //                   color: Colors.transparent,
//                 //                 ),
//                 //                 borderRadius: BorderRadius.circular(
//                 //                     20), // Adjust the radius as needed
//                 //               ),
//                 //               selected: ref.watch(selectDestination) == index,
//                 //               label: Row(
//                 //                 children: [
//                 //                   Text(
//                 //                     ref
//                 //                         .watch(positionedOrdersProvider)[index]
//                 //                         .destinationName,
//                 //                   ),
//                 //                   SizedBox(
//                 //                     width: 2,
//                 //                   ),
//                 //                   Text(
//                 //                     "(${ref.watch(positionedOrdersProvider)[index].orders.length.toString()})",
//                 //                   )
//                 //                 ],
//                 //               ),
//                 //             ),
//                 //           ),
//                 //         );
//                 //       },
//                 //     ),
//                 //   ),
//                 // ),
//                 SizedBox(
//                   height: 16,
//                 ),
//                 // Padding(
//                 //     padding: const EdgeInsetsDirectional.only(start: 16),
//                 //     child: Wrap(
//                 //       children: [
//                 //         ...ref
//                 //             .watch(positionedOrdersProvider)
//                 //             .map(
//                 //               (e) => GestureDetector(
//                 //                 onTap: () {
//                 //                   // print(e.position);
//                 //                   ref.read(selectDestination.notifier).state =
//                 //                       e.position;
//                 //                 },
//                 //                 child: Padding(
//                 //                   padding:
//                 //                       const EdgeInsetsDirectional.only(end: 4),
//                 //                   child: RawChip(
//                 //                     selected: ref.watch(selectDestination) ==
//                 //                         e.position,
//                 //                     shape: RoundedRectangleBorder(
//                 //                       side: const BorderSide(
//                 //                         width: 0,
//                 //                         color: Colors.transparent,
//                 //                       ),
//                 //                       borderRadius: BorderRadius.circular(
//                 //                           20), // Adjust the radius as needed
//                 //                     ),
//                 //                     label: Row(
//                 //                       mainAxisSize: MainAxisSize.min,
//                 //                       children: [
//                 //                         Text(
//                 //                           e.destinationName,
//                 //                         ),
//                 //                         SizedBox(
//                 //                           width: 2,
//                 //                         ),
//                 //                         Text(
//                 //                           "(${e.orders.length.toString()})",
//                 //                         )
//                 //                       ],
//                 //                     ),
//                 //                   ),
//                 //                 ),
//                 //               ),
//                 //             )
//                 //             .toList()
//                 //       ],
//                 //     )),
//                 const Padding(
//                   padding: EdgeInsetsDirectional.only(start: 16),
//                   child: Text(
//                     'Orders',
//                     textAlign: TextAlign.start,
//                     style: TextStyle(
//                       fontSize: 30,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 method2(),
//               ]
//             ],
//           ),
//           if (ref.watch(activeOrderTwoLoaderProvider))
//             ModalBarrier(
//               dismissible: false, // Prevent dismissing by tapping outside
//               color: Colors.black54,
//             ),
//           if (ref.watch(activeOrderTwoLoaderProvider))
//             Center(
//               child: GestureDetector(
//                 onTap: () => ref
//                     .read(activeOrderTwoLoaderProvider.notifier)
//                     .state = false,
//                 child: const CircularProgressIndicator(),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   Expanded method2() {
//     return Expanded(
//       // child: method1(orderListProvider),
//       child: ListView.builder(
//         itemCount: ref.watch(positionedOrdersProvider).length,
//         itemBuilder: (context, index) {
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   if (ref.watch(selectDestination) == index) {
//                     ref.read(selectDestination.notifier).state = -1;
//                   } else {
//                     ref.read(selectDestination.notifier).state = index;
//                   }
//                 },
//                 child: Row(
//                   children: [
//                     Icon(
//                       ref.watch(selectDestination) == index
//                           ? Icons.arrow_drop_down_circle
//                           : Icons.arrow_drop_up_outlined,
//                     ),
//                     Text(
//                       ref
//                           .watch(positionedOrdersProvider)[index]
//                           .destinationName,
//                       textAlign: TextAlign.start,
//                       style: const TextStyle(
//                         fontSize: 25,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       "(${ref.watch(positionedOrdersProvider)[index].orders.length.toString()})",
//                       textAlign: TextAlign.start,
//                       style: const TextStyle(
//                         fontSize: 25,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               if (ref.watch(selectDestination) == index)
//                 ...ref.watch(positionedOrdersProvider)[index].orders.map(
//                   (element) {
//                     return buildOrderCard(
//                       ordersEntity: element,
//                     );
//                   },
//                 ).toList()
//             ],
//           );
//         },
//       ),
//     );
//   }
//
//   Expanded method3() {
//     return Expanded(
//       // child: method1(orderListProvider),
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             ...ref
//                 .watch(positionedOrdersProvider)[ref.watch(selectDestination)]
//                 .orders
//                 .map(
//               (element) {
//                 return buildOrderCard(
//                   ordersEntity: element,
//                 );
//               },
//             ).toList()
//           ],
//         ),
//       ),
//     );
//   }
//
//   GroupedListView<OrdersEntity, String> method1(
//       List<OrdersEntity> orderListProvider) {
//     return GroupedListView<OrdersEntity, String>(
//       elements: orderListProvider,
//       controller: scrollController,
//       groupBy: (element) => element.destinationName,
//       indexedItemBuilder: (context, element, index) => buildOrderCard(
//         ordersEntity: element,
//       ),
//       groupSeparatorBuilder: (value) => Padding(
//         padding: const EdgeInsetsDirectional.only(
//           start: 16,
//         ),
//         child: Text(
//           value,
//           style: const TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 24,
//           ),
//         ),
//       ),
//       order: GroupedListOrder.ASC,
//     );
//   }
//
//   AppBar myAppBar(BuildContext context, getOrderProvider) {
//     return AppBar(
//       backgroundColor: ColorsApp.accentBaseColor,
//       iconTheme: IconThemeData(color: Colors.white),
//       title: Text(
//         t.orders,
//         style: TextStyle(color: Colors.white),
//       ),
//       actions: [
//         IconButton(
//           icon: Icon(
//             Icons.search,
//             color: Colors.white,
//           ),
//           onPressed: () {
//             setState(() {
//               isSearch = !isSearch;
//             });
//           },
//         ),
//         IconButton(
//           icon: const Icon(
//             Icons.autorenew_rounded,
//             color: Colors.white,
//           ),
//           onPressed: () {
//             ref
//                 .read(positionedOrdersProvider.notifier)
//                 .getOrders(type: OrderType.all);
//           },
//         ),
//         IconButton(
//           icon: Icon(
//             Icons.qr_code_scanner,
//             color: Colors.white,
//           ),
//           onPressed: () {
//             scanQRCode();
//           },
//         ),
//         IconButton(
//           icon: Icon(
//             Icons.filter_list,
//             color: Colors.white,
//           ),
//           onPressed: () {
//             showModalBottomSheet(
//               context: context,
//               builder: (context) {
//                 return Consumer(
//                   builder:
//                       (BuildContext context, WidgetRef ref, Widget? child) {
//                     return ClipRRect(
//                       borderRadius: const BorderRadius.only(
//                           topLeft: Radius.circular(20),
//                           topRight: Radius.circular(20)),
//                       child: Scaffold(
//                         body: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             const Padding(
//                               padding:
//                                   EdgeInsetsDirectional.only(end: 16, top: 16),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   CircleAvatar(
//                                     child: Icon(Icons.close),
//                                   )
//                                 ],
//                               ),
//                             ),
//                             const Padding(
//                               padding: EdgeInsetsDirectional.only(start: 16),
//                               child: Text(
//                                 'Filter',
//                                 textAlign: TextAlign.start,
//                                 style: TextStyle(
//                                   fontSize: 30,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               decoration: const BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.all(
//                                   Radius.circular(20),
//                                 ),
//                               ),
//                               padding: EdgeInsets.all(16),
//                               margin: EdgeInsetsDirectional.only(start: 16),
//                               child: Padding(
//                                 padding:
//                                     const EdgeInsetsDirectional.only(start: 16),
//                                 child: Column(
//                                   children: [
//                                     ...OrderType.values
//                                         .map(
//                                           (e) => GestureDetector(
//                                             onTap: () {
//                                               print(e);
//                                               // ref
//                                               //     .read(selectDestination
//                                               //         .notifier)
//                                               //     .state = e.position;
//                                             },
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsetsDirectional
//                                                       .only(end: 4),
//                                               child: ListTile(
//                                                 shape: RoundedRectangleBorder(
//                                                   side: const BorderSide(
//                                                     width: 0,
//                                                     color: Colors.transparent,
//                                                   ),
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           20), // Adjust the radius as needed
//                                                 ),
//                                                 title: Row(
//                                                   mainAxisSize:
//                                                       MainAxisSize.min,
//                                                   children: [
//                                                     Text(
//                                                       e.name,
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         )
//                                         .toList()
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             );
//           },
//         ),
//         // IconButton(
//         //   icon: Icon(
//         //     Icons.filter_list,
//         //     color: Colors.white,
//         //   ),
//         //   onPressed: () {
//         //     showModalBottomSheet(
//         //       context: context,
//         //       builder: (context) {
//         //         return Consumer(
//         //           builder:
//         //               (BuildContext context, WidgetRef ref, Widget? child) {
//         //             return ClipRRect(
//         //               borderRadius: const BorderRadius.only(
//         //                   topLeft: Radius.circular(20),
//         //                   topRight: Radius.circular(20)),
//         //               child: Scaffold(
//         //                 body: Column(
//         //                   crossAxisAlignment: CrossAxisAlignment.start,
//         //                   children: [
//         //                     const Padding(
//         //                       padding: EdgeInsetsDirectional.only(start: 16),
//         //                       child: Text(
//         //                         'Destination Name',
//         //                         textAlign: TextAlign.start,
//         //                         style: TextStyle(
//         //                           fontSize: 30,
//         //                           fontWeight: FontWeight.bold,
//         //                         ),
//         //                       ),
//         //                     ),
//         //                     Container(
//         //                       decoration: const BoxDecoration(
//         //                         color: Colors.white,
//         //                         borderRadius: BorderRadius.all(
//         //                           Radius.circular(20),
//         //                         ),
//         //                       ),
//         //                       padding: EdgeInsets.all(16),
//         //                       margin: EdgeInsetsDirectional.only(start: 16),
//         //                       child: Padding(
//         //                         padding:
//         //                             const EdgeInsetsDirectional.only(start: 16),
//         //                         child: Wrap(
//         //                           children: [
//         //                             ...ref
//         //                                 .watch(positionedOrdersProvider)
//         //                                 .map(
//         //                                   (e) => GestureDetector(
//         //                                     onTap: () {
//         //                                       // print(e.position);
//         //                                       ref
//         //                                           .read(selectDestination
//         //                                               .notifier)
//         //                                           .state = e.position;
//         //                                     },
//         //                                     child: Padding(
//         //                                       padding:
//         //                                           const EdgeInsetsDirectional
//         //                                               .only(end: 4),
//         //                                       child: RawChip(
//         //                                         selected: ref.watch(
//         //                                                 selectDestination) ==
//         //                                             e.position,
//         //                                         shape: RoundedRectangleBorder(
//         //                                           side: const BorderSide(
//         //                                             width: 0,
//         //                                             color: Colors.transparent,
//         //                                           ),
//         //                                           borderRadius:
//         //                                               BorderRadius.circular(
//         //                                                   20), // Adjust the radius as needed
//         //                                         ),
//         //                                         label: Row(
//         //                                           mainAxisSize:
//         //                                               MainAxisSize.min,
//         //                                           children: [
//         //                                             Text(
//         //                                               e.destinationName,
//         //                                             ),
//         //                                             SizedBox(
//         //                                               width: 2,
//         //                                             ),
//         //                                             Text(
//         //                                               "(${e.orders.length.toString()})",
//         //                                             )
//         //                                           ],
//         //                                         ),
//         //                                       ),
//         //                                     ),
//         //                                   ),
//         //                                 )
//         //                                 .toList()
//         //                           ],
//         //                         ),
//         //                       ),
//         //                     ),
//         //                   ],
//         //                 ),
//         //               ),
//         //             );
//         //           },
//         //         );
//         //       },
//         //     );
//         //   },
//         // ),
//       ],
//     );
//   }
//
//   void scanQRCode() async {
//     String result = "";
//     var res = await Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const SimpleBarcodeScannerPage(),
//         ));
//     ref.read(activeOrderTwoLoaderProvider.notifier).state = true;
//
//     if (res is String) {
//       if (res != "-1") {
//         OrdersEntity? ordersEntity = ref.read(ordersProvider).firstWhereOrNull(
//               (element) => element.barcode == res,
//             );
//         print(ordersEntity != null
//             ? "ordersEntity => ${ordersEntity.barcode}"
//             : "ordersEntity => No Order Entity");
//
//         if (ordersEntity != null) {
//           final p = await ref
//               .read(remoteOrdersRepository)
//               .getSingleOrderDetails(ordersEntity.id);
//           ref.read(activeOrderTwoLoaderProvider.notifier).state = false;
//           ref.read(navigatorProvider).push(
//                 MaterialPageRoute(
//                   builder: (context) => OrderDetailsScreen(
//                     DetilsData: p,
//                   ),
//                 ),
//               );
//         }
//         ref.read(activeOrderTwoLoaderProvider.notifier).state = false;
//       } else {
//         print("ordersEntity => canceled");
//         ref.read(activeOrderTwoLoaderProvider.notifier).state = false;
//       }
//     }
//   }
// }
//
// extension IterableExt<T> on Iterable<T> {
//   /// The first element satisfying the condition, or null if there are none.
//   T? firstWhereOrNull(bool Function(T element) test) {
//     for (var element in this) {
//       if (test(element)) return element;
//     }
//     return null;
//   }
// }
