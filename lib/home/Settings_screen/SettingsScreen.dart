import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logistics/constants/colors.dart';
import 'package:logistics/i18n/strings.g.dart';

import '../driver_status/widget/driver_drawar.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool vibrateNotification = true;
  bool soundNotification = true;
  bool showNotification = true;

  @override
  void initState() {
    super.initState();

    // configureFirebaseMessaging();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.backgroundColor,
      drawer: DriverDrawar(),
      appBar: AppBar(
        title: Text(t.Setting),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.Notifications,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey[500]!,
              ),
            ),
            SizedBox(height: 10.h),
            Card(
              color: ColorsApp.white,
              child: Column(
                children: [
                  buildNotificationOption(
                    t.alertWithVibrate,
                    vibrateNotification,
                    (bool value) {
                      setState(() {
                        vibrateNotification = value;
                      });
                    },
                  ),
                  Divider(color: Colors.grey[300]!),
                  buildNotificationOption(
                    t.alertWithSound,
                    soundNotification,
                    (bool value) {
                      setState(() {
                        soundNotification = value;
                      });
                    },
                  ),
                  Divider(color: Colors.grey[300]!),
                  buildNotificationOption(
                    t.showNotifications,
                    showNotification,
                    (bool value) {
                      setState(() {
                        showNotification = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNotificationOption(
      String title, bool value, ValueChanged<bool> onChanged) {
    return ListTile(
      title: Text(title),
      trailing: Transform.scale(
        scale: 0.9.sp,
        child: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: ColorsApp.primaryColor,
          inactiveTrackColor: ColorsApp.white,
        ),
      ),
    );
  }

  void configureFirebaseMessaging() {
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

    firebaseMessaging.requestPermission();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      firebaseMessaging.getToken().then((token) {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text(message.notification?.title ?? ''),
            content: Text(message.notification?.body ?? ''),
          ),
        );
        print('Token: $token');
      });

      firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: showNotification,
        sound: soundNotification,
      );
    });
  }
}
