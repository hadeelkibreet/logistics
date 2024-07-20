import 'package:flutter/material.dart';
//import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:logistics/constants/colors.dart';
import 'package:logistics/constants/images.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsOrderScreen extends ConsumerStatefulWidget {
  const DetailsOrderScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<DetailsOrderScreen> createState() => _detailsOrderScreenState();
}

class _detailsOrderScreenState extends ConsumerState<DetailsOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              color: Colors.grey[300],
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 300.h,
                        child: FlutterMap(
                          options: MapOptions(
                            center:
                                LatLng(24.778810, 46.730354), // إحداثيات الموقع
                            zoom: 14.0.sp,
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
                                  point: LatLng(
                                      24.778810, 46.730354), // إحداثيات الموقع
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
                      ),
                      Positioned.fill(
                        child: Material(
                          color: Color(0x629D9D9D),
                          child: InkWell(
                            onTap: _launchMapsUrl,
                          ),
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
                                  'T',
                                  style: TextStyle(color: ColorsApp.white),
                                ),
                              ),
                              Text(
                                'test',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                'KSA-riyadh, KSA-riyadh, 123, UNKNOWN',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                height: 80.h,
                              ),
                              Text(
                                'رقم الطلب: 9937664235780',
                                style: TextStyle(
                                    fontSize: 25.sp,
                                    color: ColorsApp.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 28.sp),
                                child: Container(
                                  color: Colors.orange,
                                  width: double.infinity,
                                  padding: EdgeInsets.all(8.0.sp),
                                  child: Text(
                                    'تم القبول',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18.sp),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 250.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10.0.sp),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.green,
                                    child: IconButton(
                                      icon: Icon(Icons.phone,
                                          color: ColorsApp.white),
                                      onPressed: () {
                                        callNumber('0503792580');
                                      },
                                    ),
                                    maxRadius: 25.sp,
                                    minRadius: 25.sp,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0.sp),
                                  child: InkWell(
                                    onTap: () => openWhatsApp('0503792580'),
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

            Padding(
              padding: EdgeInsets.all(5.0.sp),
              child: Container(
                width: 350.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.sp),
                  color: Colors.blue,
                ),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'طلب تحديث الموقع',
                    style: TextStyle(color: ColorsApp.white, fontSize: 18.sp),
                  ),
                ),
              ),
            ),
            Divider(color: Colors.grey),

            Card(
              margin: EdgeInsets.all(7.0),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 105, vertical: 10),
                child: Column(
                  children: [
                    Text(
                      'المبلغ المطلوب استلامه',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    SizedBox(height: 3),
                    Text(
                      '0.00 SAR',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.arrow_drop_down_outlined),
                  Container(
                    width: 228,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Text('  تفاصيل إضافية '),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Text(
                '  معلومات الرحلة ',
                textAlign: TextAlign.end,
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),

            // Additional Details Card
            Card(
              color: ColorsApp.white,
              margin: EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildRowItem(
                      context,
                      'KSA-riyadh, KSA-riyadh, 123, UNKNOWN',
                      'test الى',
                      Icons.phone,
                      Colors.blue,
                    ),
                    _buildRowItem(
                      context,
                      'KSA-riyadh, 31758, UNKNOWN',
                      'test من',
                      Icons.phone,
                      Colors.green,
                    ),
                    // Divider(height: 32),
                    _buildInfoItem(
                        context,
                        'نوع الخدمة',
                        'Express ',
                        Icons.local_shipping,
                        Colors.yellow,
                        '0.00 SAR',
                        true,
                        0,
                        true,
                        SizedBox(
                          height: 0,
                        )),
                    _buildInfoItem(
                        context,
                        'تاريخ الإنشاء',
                        'Apr ',
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
                        'فترة الوقت لحمل الشحنة',
                        ' ممكن',
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
            SizedBox(height: 10),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Text(
                '  معلومات الطرد ',
                textAlign: TextAlign.end,
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            Card(
              color: ColorsApp.white,
              margin: EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildInfoItem(
                        context,
                        'نوع الطرد',
                        'Exdium ',
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
                        'الوصف',
                        'test ',
                        Icons.edit,
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
                        'صورة الطرد',
                        ' لايوجد',
                        Icons.image,
                        Colors.purple,
                        '',
                        false,
                        0,
                        false,
                        Image.network(
                            width: 280,
                            height: 200,
                            'https://www.syncfusion.com/blogs/wp-content/uploads/2021/04/How-to-perform-text-search-over-the-PDF-document-using-Flutter-PDF-Viewer.png')),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Text(
                '  إثبات التوصيل ',
                textAlign: TextAlign.end,
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            Card(
              color: ColorsApp.white,
              margin: EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildInfoItem(
                        context,
                        'إسم المرسل إليه / المستلم',
                        'test ',
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
                        'إثبات هوية المستلم',
                        'test ',
                        Icons.badge_sharp,
                        Colors.blueAccent,
                        '',
                        false,
                        0,
                        false,
                        SizedBox(
                          height: 20,
                        )),
                    _buildInfoItem(
                        context,
                        'توقيع المستلم',
                        ' لايوجد',
                        Icons.edit,
                        Colors.red,
                        '',
                        false,
                        0,
                        false,
                        SizedBox(
                          height: 20,
                        )),
                    _buildInfoItem(
                        context,
                        'حالة التوصيل',
                        ' ',
                        Icons.assignment_turned_in_rounded,
                        Colors.green,
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
            // Sender Information Card

            // Delivery Proof Card
            SizedBox(height: 10),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Text(
                '  معلومات الدفع ',
                textAlign: TextAlign.end,
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            Card(
              color: ColorsApp.white,
              margin: EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildInfoItem(
                        context,
                        'نوع الدفع',
                        'نقدي ',
                        Icons.attach_money,
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
                        'تم الدفع عن طريق',
                        'test ',
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
                        'تكلفة الخدمة',
                        ' لايوجد',
                        Icons.money_rounded,
                        Colors.lightGreen,
                        'مدفوع',
                        true,
                        1,
                        true,
                        SizedBox(
                          height: 0,
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),

            // Payment Information Card
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50.h,
                    color: Color(0xFFF35395B),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'في مرحلة الشحن',
                        style: TextStyle(color: ColorsApp.white),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 50.h,
                    color: Colors.red,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'رفض',
                        style: TextStyle(color: ColorsApp.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Bottom Buttons
          ],
        ),
      ),
    );
  }

  Widget _buildRowItem(
    BuildContext context,
    String address,
    String name,
    IconData icon,
    Color avatarColor,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(icon, color: ColorsApp.black),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(address, style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
        SizedBox(width: 8),
        CircleAvatar(
          backgroundColor: avatarColor,
          child:
              Text(name.substring(0, 1), style: TextStyle(color: Colors.white)),
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
      bool isCash,
      int cashColor,
      bool isValue,
      Widget widgetValue) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isCash
              ? Text(cash,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: cashColor == 1 ? Colors.green : Colors.black))
              : SizedBox(
                  width: 0,
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(title,
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      SizedBox(width: 8),
                      CircleAvatar(
                        child: Icon(icon, color: iconColor),
                        backgroundColor: Colors.grey[350],
                      ),
                    ],
                  ),
                  isValue
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: Text(value,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        )
                      : widgetValue,
                ],
              ),
              SizedBox(width: 8),
            ],
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
    String url = "https://wa.me/$WhatsappNumber";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Unable to open WhatsApp";
    }
  }
}
