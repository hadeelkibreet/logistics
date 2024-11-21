import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logistics/constants/colors.dart';
import 'package:logistics/i18n/strings.g.dart';
import 'package:logistics/logistic_app.dart';
import 'package:logistics/orders/active_orders/active_orders.dart';
import 'package:logistics/orders/entity/orders_entity.dart';
import 'package:logistics/orders/in_way/in_way_screen.dart';
import 'package:logistics/orders/repository/remote_orders_repository.dart';

class buildOrderCard extends ConsumerStatefulWidget {
  OrdersEntity ordersEntity;
  buildOrderCard({
    Key? key,
    required this.ordersEntity,
  }) : super(key: key);

  @override
  _buildOrderCardState createState() => _buildOrderCardState();
}

class _buildOrderCardState extends ConsumerState<buildOrderCard> {
  var isClicked = false;
  late Timer _timer;
  int interval = 1000;

  _startTimer() {
    _timer = Timer(Duration(milliseconds: interval), () => isClicked = false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
      child: GestureDetector(
        onTap: () async {
          try {
            ref.read(activeOrderLoaderProvider.notifier).state = true;
            final p = await ref
                .read(remoteOrdersRepository)
                .getSingleOrderDetails(widget.ordersEntity.id);

            ref.read(navigatorProvider).push(
                  MaterialPageRoute(
                    builder: (context) => OrderDetailsScreen(
                      DetilsData: p,
                    ),
                  ),
                );
            ref.read(activeOrderLoaderProvider.notifier).state = false;
          } catch (e) {
            e.toString();
            ref.read(activeOrderLoaderProvider.notifier).state = false;
          }
        },
        child: Card(
          color: ColorsApp.white,
          margin: EdgeInsets.symmetric(vertical: 8.0.sp),
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 10.sp, vertical: 4.sp),
                child: Row(
                  children: [
                    // CircleAvatar(
                    //   backgroundColor: Colors.grey[300],
                    //   child: Text(
                    //     widget.ordersEntity.,
                    //     style: TextStyle(color: Colors.black),
                    //   ),
                    // ),

                    SizedBox(width: 8.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.ordersEntity.ref.toString(),
                            ),
                            Text(
                              ' | ',
                              style: TextStyle(color: Colors.grey[300]),
                            ),
                            Text(
                              widget.ordersEntity.status,
                              // style: TextStyle(color: widget.statusCard.color),
                            ),
                          ],
                        ),
                        Container(
                          width: 500,
                          constraints: BoxConstraints(maxWidth: 260.w),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.ordersEntity.destinationAddress,
                                style: TextStyle(fontSize: 14.sp),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                ", ",
                                style: TextStyle(fontSize: 14.sp),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                widget.ordersEntity.destinationName,
                                style: TextStyle(fontSize: 14.sp),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(4.0.sp),
                          child: const Icon(
                            Icons.assignment_outlined,
                            color: Colors.grey,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Order # : ',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            Container(
                              constraints: BoxConstraints(maxWidth: 210.w),
                              child: Text(
                                widget.ordersEntity.barcode,
                                style: TextStyle(fontSize: 14.sp),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    widget.ordersEntity.status == "1"
                        ? Text(
                            t.done,
                            style: TextStyle(color: Colors.amber),
                          )
                        : Text('')
                  ],
                ),
              ),
              SizedBox(height: 8.sp),
            ],
          ),
        ),
      ),
    );
  }
}
