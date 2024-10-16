import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logistics/auth/entity/login_entity.dart';
import 'package:logistics/auth/providers/login_provider.dart';
import 'package:logistics/constants/colors.dart';
import 'package:logistics/constants/dio.dart';
import 'package:logistics/constants/endpoints.dart';
import 'package:logistics/constants/images.dart';
import 'package:logistics/driver_status/driverStatusScreen.dart';
import 'package:logistics/profile/entity/profile_entity.dart';

import '../data/prefs/prefs.dart';
import '../i18n/strings.g.dart' show Translations, AppLocale, LocaleSettings, t;

class LogInScreen extends ConsumerStatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends ConsumerState<LogInScreen> {
  final GlobalKey _formkey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;

  // @override
  // void dispose() {
  //   _phoneController.dispose();
  //   _passwordController.dispose();
  //   super.dispose();
  // }

  Future<void> _response() async {
    var data = FormData.fromMap({'phone': '${_phoneController.text}'});
    var response =
        await ApiService().postData(data, Endpoints.login.toString());
    await _postLoginEntityData(response);
    var responsegetdata =
        await ApiService().getData(Endpoints.getProfile.toString(), ref);
    await _saveProfileEntityData(responsegetdata);
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
    final AppLocale activeLocale = LocaleSettings.currentLocale;
    final loginApi = ref.watch(LoginProvider);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: ColorsApp.primaryColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // SizedBox(
                  //   height: height * 0.06,
                  // ),
                  Image.asset(
                    ImageAssets.logo,
                    width: width * 0.8.w,
                    height: height * 0.5.h,
                  ),
                  //  SizedBox(height: height * 0.04),
                  // DefaultTextStyle(
                  //   style: TextStyle(
                  //     color: ColorsApp.white,
                  //     fontSize: 35.sp,
                  //     fontWeight: FontWeight.w900,
                  //   ),
                  //   child: Text(t.LogIn),
                  // ),
                  // SizedBox(
                  //   height: height * 0.04,
                  // ),
                  Container(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 15.sp),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
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
                            prefixIcon: Icon(
                              Icons.phone_android_sharp,
                              color: ColorsApp.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  // Container(
                  //   padding: EdgeInsetsDirectional.symmetric(horizontal: 15.sp),
                  //   child: TextFormField(
                  //     controller: _passwordController,
                  //     validator: (value) {
                  //       if (value!.isEmpty) {
                  //         return t.EnterThePassword;
                  //       }
                  //       // Add additional validation logic here if needed
                  //       return null; // Return null if the value is valid
                  //     },
                  //
                  //     // textAlign: TextAlign.right,
                  //     obscureText: !_passwordVisible,
                  //     decoration: InputDecoration(
                  //       hintText: t.EnterThePassword,
                  //       hintStyle: TextStyle(color: Colors.grey),
                  //       filled: true,
                  //       fillColor: ColorsApp.white,
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(30.0.sp),
                  //         borderSide: BorderSide.none,
                  //       ),
                  //       contentPadding: EdgeInsets.symmetric(
                  //           vertical: 15.0.sp, horizontal: 20.0.sp),
                  //       suffixIcon: GestureDetector(
                  //         onTap: () {
                  //           setState(() {
                  //             _passwordVisible = !_passwordVisible;
                  //           });
                  //         },
                  //         child: Icon(
                  //           _passwordVisible
                  //               ? Icons.visibility
                  //               : Icons.visibility_off,
                  //           color: Colors.grey.withOpacity(0.9),
                  //         ),
                  //       ),
                  //       prefixIcon: Icon(
                  //         Icons.password,
                  //         color: ColorsApp.primaryColor,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: height * 0.04,
                  // ),
                  Container(
                    width: width * 0.5,
                    height: height * 0.07,
                    child: ElevatedButton(
                        onPressed: () async {
                          await _response();
                          // _passwordController.text.toString() ==
                          //         loginApi.value!.passWord.toString()
                          //     ? print('yeessss1')
                          //     : print('noooooo1');
                          // _phoneController.text.toString() ==
                          //         loginApi.value!.phoneNumber.toString()
                          //     ? print('yeessss')
                          //     : print(loginApi.value!.phoneNumber.toString());

                          final Prehelper = ref.read(prefHelperProvider);
                          Prehelper.setLoggedIn();
                          //sp.setBool('isLogin', true);
                          print("is login ${Prehelper.getIsLoggedIn}");

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DriverStatusScreen(),
                              //DriverStatusScreen(),
                            ),
                          );

                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => DriverStatusScreen()));
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              ColorsApp.yellow),
                        ),
                        child: Text(
                          t.LogIn,
                          style: TextStyle(
                            color: ColorsApp.black,
                            fontSize: 16.sp,
                          ),
                        )),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  // Container(
                  //   width: width * 0.5,
                  //   height: height * 0.07,
                  //   child: ElevatedButton(
                  //       onPressed: () async {
                  //         activeLocale == AppLocale.en
                  //             ? LocaleSettings.setLocale(AppLocale.ar)
                  //             : LocaleSettings.setLocale(AppLocale.en);
                  //       },
                  //       style: ButtonStyle(
                  //         backgroundColor: MaterialStateProperty.all<Color>(
                  //             ColorsApp.yellow),
                  //       ),
                  //       child: Text(
                  //         '${t.changeToEnglish}',
                  //         style: TextStyle(
                  //           color: ColorsApp.black,
                  //           fontSize: 16.sp,
                  //         ),
                  //       )),
                  // ),
                ],
              ),
            ),
          ),
        ));
  }
}
