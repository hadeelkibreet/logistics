import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics/auth/login.dart';
import 'package:logistics/data/prefs/prefs.dart';
import 'package:logistics/driver_status/driverStatusScreen.dart';
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

    isLogin();
  }

  void isLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    final Prehelper = PrefsHelper(sp);
    //bool? isLogin = sp.getBool('isLogin') ?? false;
    bool? isLogin = Prehelper.getIsLoggedIn ?? false;

    print("is lohin ${s.getIsLoggedIn}");
    if (isLogin) {
      Timer(const Duration(seconds: 5), () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const DriverStatusScreen()));
      });
    } else {
      Timer(const Duration(seconds: 5), () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LogInScreen()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
