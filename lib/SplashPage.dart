import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics/auth/login.dart';
import 'package:logistics/data/prefs/prefs.dart';
import 'package:logistics/driver_status/driverStatusScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/dio.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    var data = FormData.fromMap({'phone': '0555109992'});

    await _checkLoginStatus();
    ApiService().postData(data);
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    final preHelper = PrefsHelper(sp);
    bool? isLogin = preHelper.getIsLoggedIn ?? false;

    print("is login ${preHelper.getIsLoggedIn}");
    Timer(const Duration(seconds: 5), () {
      final nextPage =
          isLogin ? const DriverStatusScreen() : const LogInScreen();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => nextPage));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
