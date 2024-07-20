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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.grey[300],
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 200.h,
                        child: FlutterMap(
                          options: MapOptions(
                            center:
                                LatLng(33.509883, 36.305231), // إحداثيات الموقع
                            zoom: 17.0.sp,
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
                                      33.509883, 36.305231), // إحداثيات الموقع
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
                          padding: EdgeInsets.only(top: 40),
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.red,
                                child: Text('T'),
                              ),
                              Text(
                                'KSA-riyadh, KSA-riyadh, 123, UNKNOWN',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                'رقم الطلب: 9937664235780',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 92),
                                child: Container(
                                  color: Colors.orange,
                                  width: double.infinity,
                                  padding: EdgeInsets.all(12.0),
                                  child: Text(
                                    'تم القبول',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 185),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.green,
                                    child: IconButton(
                                      icon: Icon(Icons.phone,
                                          color: ColorsApp.white),
                                      onPressed: () {
                                        callNumber('0503792580');
                                      },
                                    ),
                                    maxRadius: 25,
                                    minRadius: 25,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () => openWhatsApp('0503792580'),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Image.asset(
                                        ImageAssets.whatsapp,
                                        height: 25,
                                        width: 25,
                                      ),
                                      maxRadius: 25,
                                      minRadius: 25,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: IconButton(
                                      icon: Icon(Icons.cloud_download,
                                          color: Colors.grey),
                                      onPressed: () {
                                        //   downloadAndConvertImageToPDF();
                                      },
                                    ),
                                    maxRadius: 25,
                                    minRadius: 25,
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
            // Order Actions

            // Request Location Update Button
            Container(
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {},
                child: Text('طلب تحديث الموقع'),
              ),
            ),
            // Payment Details Card
            Card(
              margin: EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'المبلغ المطلوب استلامه',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '0.00 SAR',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            // Additional Details Card
            Card(
              margin: EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text('test'),
                      subtitle: Text('KSA-riyadh, KSA-riyadh, 123, UNKNOWN'),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text('توصيل'),
                      subtitle: Text('KSA-riyadh, 31758, UNKNOWN'),
                    ),
                    ListTile(
                      leading: Icon(Icons.delivery_dining),
                      title: Text('Express Delivery'),
                      subtitle: Text('Apr 04, 2021 01:04 PM'),
                    ),
                  ],
                ),
              ),
            ),
            // Sender Information Card
            Card(
              margin: EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'معلومات المرسل',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    ListTile(
                      leading: Icon(Icons.info),
                      title: Text('نوع الطرد'),
                      subtitle: Text('MEDIUM'),
                    ),
                    ListTile(
                      leading: Icon(Icons.description),
                      title: Text('الوصف'),
                      subtitle: Text('Test'),
                    ),
                    ListTile(
                      leading: Icon(Icons.image),
                      title: Text('صور الطرد'),
                      subtitle: Text('غير متاحة'),
                    ),
                  ],
                ),
              ),
            ),
            // Delivery Proof Card
            Card(
              margin: EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'إثبات التوصيل',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text('إسم المرسل إليه / المستلم'),
                      subtitle: Text('test'),
                    ),
                    ListTile(
                      leading: Icon(Icons.card_membership),
                      title: Text('إثبات هوية المستلم'),
                      subtitle: Text('غير متاحة'),
                    ),
                  ],
                ),
              ),
            ),
            // Payment Information Card
            Card(
              margin: EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'معلومات الدفع',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    ListTile(
                      leading: Icon(Icons.payment),
                      title: Text('نوع الدفع'),
                      subtitle: Text('نقدي'),
                    ),
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text('تم الدفع عن طريق'),
                      subtitle: Text('test (Sender)'),
                    ),
                    ListTile(
                      leading: Icon(Icons.money),
                      title: Text('تكلفة الخدمة'),
                      subtitle: Text('0.00 SAR'),
                    ),
                    ListTile(
                      leading: Icon(Icons.attach_money),
                      title: Text('إجمالي المبلغ'),
                      subtitle: Text('0.00 SAR'),
                    ),
                  ],
                ),
              ),
            ),
            // Bottom Buttons
            Container(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: Text('في مرحلة حمل الشحنة'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: Text('رفض'),
                  ),
                ],
              ),
            ),
          ],
        ),
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
