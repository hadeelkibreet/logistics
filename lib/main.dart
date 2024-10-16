import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics/firebase_options.dart';
import 'package:logistics/i18n/strings.g.dart';
import 'package:logistics/logistic_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  CollectionReference<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('inMonth');

  LocaleSettings.setLocale(AppLocale.en);

  runApp(
    ProviderScope(
      child: TranslationProvider(
        child: const LogisticsApp(),
      ),
    ),
  );
}
