import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logistics/constants/colors.dart';

class buildOrderCard extends StatefulWidget {
  final String name;
  final int numberOfLength;
  final String orderNumber;
  final double lat;
  final double long;
  final bool isdone;
  buildOrderCard(
      {Key? key,
      required this.name,
      required this.numberOfLength,
      required this.orderNumber,
      required this.lat,
      required this.long,
      required this.isdone})
      : super(key: key);

  @override
  State<buildOrderCard> createState() => _buildOrderCardState();
}

class _buildOrderCardState extends State<buildOrderCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: Card(
        color: ColorsApp.white,
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    child: Text(
                      widget.numberOfLength.toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'المقيم ',
                            style: TextStyle(color: Colors.green),
                          ),
                          Text(
                            '|',
                            style: TextStyle(color: Colors.grey[300]),
                          ),
                          Text(
                            widget.isdone ? 'توصيل' : ' تحميل الشحنة',
                            style: TextStyle(
                                color: widget.isdone
                                    ? Colors.amber
                                    : Colors.green),
                          ),
                        ],
                      ),
                      Container(
                        constraints: BoxConstraints(maxWidth: 260.w),
                        child: Text(widget.name,
                            style: TextStyle(fontSize: 14),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.assignment_outlined,
                          color: Colors.grey,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'طلب #: ',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          Container(
                            constraints: BoxConstraints(maxWidth: 210.w),
                            child: Text(
                              widget.orderNumber,
                              style: TextStyle(fontSize: 14),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  widget.isdone
                      ? Text(
                          'تم توصيل ',
                          style: TextStyle(color: Colors.amber),
                        )
                      : Text('')
                ],
              ),
            ),
            SizedBox(height: 8),
            widget.isdone
                ? SizedBox()
                : Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadiusDirectional.only(
                                bottomStart: Radius.circular(12),
                              )),
                          height: 50.h,
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'إستخدم الخريطة',
                                style: TextStyle(color: ColorsApp.white),
                              )),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadiusDirectional.only(
                                bottomEnd: Radius.circular(12),
                              )),
                          height: 50.h,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'إبدأ',
                              style: TextStyle(color: ColorsApp.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
