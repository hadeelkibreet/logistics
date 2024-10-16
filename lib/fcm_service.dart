
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FCMService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> setupFCM() async {
    await setupNotificationChannel();
    // Request permissions for iOS
    await _firebaseMessaging.requestPermission();

    // Initialize local notifications
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a message in the foreground: ${message.data}');
      _showNotification(message);
    });

    // Get the token for the device
    String? token = await _firebaseMessaging.getToken();
    print("FCM Token: $token");
  }

  Future<void> _showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
      payload: message.data['some_data'], // Pass any data you want
    );
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // This will be called when the app is in the background or terminated
    print('Handling a background message: ${message.messageId}');
    // Here, you can display a notification or handle the message data
    // You can also call _showNotification() if needed
  }

  Future<void> setupNotificationChannel() async {
    if (Platform.isAndroid) {
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'your_channel_id', // Replace with your channel ID
        'your_channel_name', // Replace with your channel name
        description:
            'your_channel_description', // Replace with your channel description
        importance: Importance.high,
      );

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }
  }
}
