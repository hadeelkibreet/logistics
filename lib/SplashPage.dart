import 'dart:async';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logistics/auth/login.dart';
import 'package:logistics/block_him.dart';
import 'package:logistics/constants/colors.dart';
import 'package:logistics/data/prefs/prefs.dart';
import 'package:logistics/orders/active_orders/active_orders.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    await _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    final preHelper = PrefsHelper(sp);
    bool isLogin = preHelper.getIsLoggedIn;

    print("is login ${preHelper.getIsLoggedIn}");

    bool blockHim = FirebaseRemoteConfig.instance.getBool("forceUpdate");
    if (blockHim == true) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ForceUpdateScreen()));
      return;
    }
    Timer(const Duration(seconds: 5), () {
      final nextPage = isLogin ? ActiveOrders() : const LogInScreen();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => nextPage));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsApp.primaryColor,
        body: Center(
          child: Column(
            children: [
              SvgPicture.asset(
                "assets/images/logo.svg",
              ),
              CircularProgressIndicator(
                color: ColorsApp.white,
              ),
            ],
          ),
        ));
  }
}
