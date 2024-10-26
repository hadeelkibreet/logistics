import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics/firebase_options.dart';
import 'package:logistics/fcm_service.dart';
import 'package:logistics/i18n/strings.g.dart';
import 'package:logistics/logistic_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  CollectionReference<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('inMonth');

  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 0),
    minimumFetchInterval: const Duration(seconds: 0),
  ));
  remoteConfig.fetchAndActivate();

  // final fcmService = FCMService();
  // await fcmService.setupFCM();

//     FirebaseMessaging messaging =
//     FirebaseMessaging.instance;
// messaging.requestPermission();
// messaging.getToken().then((token) {
//   print('Token: $token');
// });
// FirebaseMessaging.onMessage
//     .listen((RemoteMessage message) {
//   print(
//       'Received notification: ${message.notification?.title} - ${message.notification?.body}');
// });

  LocaleSettings.setLocale(AppLocale.en);

  runApp(
    ProviderScope(
      child: TranslationProvider(
        child: const LogisticsApp(),
      ),
    ),
  );
}
