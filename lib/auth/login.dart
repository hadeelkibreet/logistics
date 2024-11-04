import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logistics/SplashPage.dart';
import 'package:logistics/auth/entity/login_entity.dart';
import 'package:logistics/constants/colors.dart';
import 'package:logistics/constants/dio.dart';
import 'package:logistics/constants/endpoints.dart';
import 'package:logistics/orders/active_orders/active_orders.dart';
import 'package:logistics/profile/entity/profile_entity.dart';
import 'package:logistics/constants/app_dimensions.dart';

import '../data/prefs/prefs.dart';
import '../i18n/strings.g.dart' show Translations;

class LogInScreen extends ConsumerStatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends ConsumerState<LogInScreen> {
  final _formKey = GlobalKey<FormState>(); // Correct initialization
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;

  // @override
  // void dispose() {
  //   _phoneController.dispose();
  //   _passwordController.dispose();
  //   super.dispose();
  // }

  Future<void> _login(BuildContext buildContext) async {
    if (!buildContext.mounted) {
      return;
    }
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

    String? fcm_token = "";

    try {
      fcm_token = await _firebaseMessaging.getToken();
    } catch (_) {}

    var data = FormData.fromMap(
      {
        'phone': _phoneController.text,
        'password': _passwordController.text,
        'fcm_token': fcm_token ?? ''
      },
    );
    Response response = await ApiService().postData(
      data,
      Endpoints.login.toString(),
    );

    switch (response.statusCode) {
      case 200:
        await _postLoginEntityData(response);
        var loginResponse = await ApiService().getData(
          Endpoints.getProfile.toString(),
          ref,
        );
        await _saveProfileEntityData(
          loginResponse,
        );
        ref.read(prefHelperProvider).setLoggedIn();
        // Navigator.pushReplacement(
        //   buildContext,
        //   MaterialPageRoute(
        //     builder: (context) => ActiveOrders(),
        //   ),
        // );
        // Navigator.replace(context,
        //     oldRoute: MaterialPageRoute(builder: (context) => SplashPage()),
        //     newRoute: MaterialPageRoute(builder: (context) => ActiveOrders()));
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => ActiveOrders()),
          (Route<dynamic> route) =>
              false, // This will remove all previous routes
        );
        break;
      case 302:
        ScaffoldMessenger.of(buildContext).showSnackBar(
          SnackBar(content: Text(response.data['error'])),
        );
        break;
      case 401:
        ScaffoldMessenger.of(buildContext).showSnackBar(
          SnackBar(content: Text(response.data['error'])),
        );
        break;
    }
  }

  Future<void> _saveProfileEntityData(responseData) async {
    //SharedPreferences sp = await SharedPreferences.getInstance();
    //final preHelper = PrefsHelper(sp);
    final preHelper = ref.read(prefHelperProvider);
    // Assuming the API response contains the ProfileEntity data
    ProfileEntity profileEntity = ProfileEntity.fromJson(responseData);
    preHelper.saveProfileEntity(profileEntity);

    // Retrieve and print the saved ProfileEntity
    ProfileEntity? retrievedEntity = preHelper.getProfileEntity();
    print("Saved ProfileEntity Name: ${retrievedEntity?.name}");
    print("Authorization Token: ${preHelper.getUserToken}");
  }

  Future<void> _postLoginEntityData(response) async {
    if (response.statusCode == 200) {
      final preHelper = ref.read(prefHelperProvider);
      LoginEntity loginEntity = LoginEntity.fromJson(response.data);
      if (!preHelper.getUserToken.contains("Bearer")) {
        preHelper.setUserToken(loginEntity.accessToken);
      }
      preHelper.saveLoginEntity(loginEntity);
      LoginEntity? infoEntity = preHelper.getLoginEntity();
      print("1${response.data}");
      print("2${infoEntity!.user.name.toString()}");
      print("3${preHelper.getUserToken}");
    } else {
      print("4${response.statusMessage}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorsApp.primaryColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppDimensions.p32 * 2,
              ),
              child: SvgPicture.asset(
                "assets/images/logo.svg",
                height: height / 10,
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.p16,
                      vertical: AppDimensions.p8,
                    ),
                    child: TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return t.EnterAphoneNumber;
                        }
                        return null;
                      },
                      //textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        hintText: "${t.EnterAphoneNumber}",
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: ColorsApp.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0.sp),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 15.0.sp, horizontal: 20.0.sp),
                        prefixIcon: const Icon(
                          Icons.phone_android_sharp,
                          color: ColorsApp.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.p16,
                      vertical: AppDimensions.p8,
                    ),
                    child: TextFormField(
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return t.EnterThePassword;
                        }
                        // Add additional validation logic here if needed
                        return null; // Return null if the value is valid
                      },
                      // textAlign: TextAlign.right,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        hintText: t.EnterThePassword,
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: ColorsApp.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0.sp),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 15.0.sp, horizontal: 20.0.sp),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                          child: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey.withOpacity(0.9),
                          ),
                        ),
                        prefixIcon: const Icon(
                          Icons.password,
                          color: ColorsApp.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: width / 2,
                    padding: EdgeInsets.only(top: AppDimensions.p16),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await _login(context);
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                          ColorsApp.secondaryColor,
                        ),
                      ),
                      child: Text(
                        t.LogIn,
                        style: TextStyle(
                          color: ColorsApp.white,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: width / 2,
                    padding: EdgeInsets.only(top: AppDimensions.p16),
                    child: ElevatedButton(
                      onPressed: () {
                        _phoneController.text = '0555109992';
                        _passwordController.text = '12312300';
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                          ColorsApp.secondaryColor,
                        ),
                      ),
                      child: Text(
                        "Testing",
                        style: TextStyle(
                          color: ColorsApp.white,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
