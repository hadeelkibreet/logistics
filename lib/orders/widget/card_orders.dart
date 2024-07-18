import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logistics/constants/colors.dart';
import 'package:logistics/i18n/strings.g.dart';
import 'package:url_launcher/url_launcher.dart';

class buildOrderCard extends StatefulWidget {
  final String name;
  final int numberOfLength;
  final String orderNumber;
  final double lat;
  final double long;
  final int statusCard;
  buildOrderCard(
      {Key? key,
      required this.name,
      required this.numberOfLength,
      required this.orderNumber,
      required this.lat,
      required this.long,
      required this.statusCard})
      : super(key: key);

  @override
  State<buildOrderCard> createState() => _buildOrderCardState();
}

class _buildOrderCardState extends State<buildOrderCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
      child: Card(
        color: ColorsApp.white,
        margin: EdgeInsets.symmetric(vertical: 8.0.sp),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 4.sp),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    child: Text(
                      widget.numberOfLength.toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            t.resident,
                            style: TextStyle(color: Colors.green),
                          ),
                          Text(
                            '|',
                            style: TextStyle(color: Colors.grey[300]),
                          ),
                          Text(
                            widget.statusCard == 1
                                ? t.delivery
                                : t.LoadingTheShipment,
                            style: TextStyle(
                                color: widget.statusCard == 1
                                    ? Colors.amber
                                    : Colors.green),
                          ),
                        ],
                      ),
                      Container(
                        constraints: BoxConstraints(maxWidth: 260.w),
                        child: Text(widget.name,
                            style: TextStyle(fontSize: 14.sp),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
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
                        child: Icon(
                          Icons.assignment_outlined,
                          color: Colors.grey,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${t.order} #: ',
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
                              style: TextStyle(fontSize: 14.sp),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  widget.statusCard == 1
                      ? Text(
                          t.done,
                          style: TextStyle(color: Colors.amber),
                        )
                      : Text('')
                ],
              ),
            ),
            SizedBox(height: 8.sp),
            widget.statusCard == 1
                ? SizedBox()
                : Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            _launchMapsUrl();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadiusDirectional.only(
                                  bottomStart: Radius.circular(12.sp),
                                )),
                            height: 50.h,
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  t.usingTheMap,
                                  style: TextStyle(color: ColorsApp.white),
                                )),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadiusDirectional.only(
                                bottomEnd: Radius.circular(12.sp),
                              )),
                          height: 50.h,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              t.Start,
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

  Future<void> _launchMapsUrl() async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=${widget.lat},${widget.long}';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
