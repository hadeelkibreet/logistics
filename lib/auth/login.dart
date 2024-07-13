import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logistics/constants/colors.dart';
import 'package:logistics/constants/images.dart';

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

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final AppLocale activeLocale = LocaleSettings.currentLocale;
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
                  SizedBox(
                    height: height * 0.06,
                  ),
                  Image.asset(
                    ImageAssets.logo,
                    width: width * 0.5,
                  ),
                  SizedBox(height: height * 0.06),
                  DefaultTextStyle(
                    style: TextStyle(
                      color: ColorsApp.white,
                      fontSize: 35.sp,
                      fontWeight: FontWeight.w900,
                    ),
                    child: Text('تسجيل الدخول'),
                  ),
                  SizedBox(
                    height: height * 0.06,
                  ),
                  Container(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 15.sp),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: _phoneController,
                          validator: (value) {
                            if (value!.isEmpty || !value.contains("05")) {
                              return 'الرجاء كتابة الرقم';
                            }
                            // Add additional validation logic here if needed
                            return null; // Return null if the value is valid
                          },
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            hintText: 'ادخل رقم الجوال',
                            hintStyle: TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: ColorsApp.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0.sp),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15.0.sp, horizontal: 20.0.sp),
                            suffixIcon: Icon(
                              Icons.phone_enabled,
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
                  Container(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 15.sp),
                    child: TextFormField(
                      controller: _passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'الرجاءادخال كلمة المرور';
                        }
                        // Add additional validation logic here if needed
                        return null; // Return null if the value is valid
                      },
                      textAlign: TextAlign.right,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        hintText: 'ادخل كلمة المرور',
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: ColorsApp.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0.sp),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 15.0.sp, horizontal: 20.0.sp),
                        suffixIcon: Icon(
                          Icons.password,
                          color: ColorsApp.primaryColor,
                        ),
                        prefixIcon: GestureDetector(
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
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Container(
                    width: width * 0.5,
                    height: height * 0.07,
                    child: ElevatedButton(
                        onPressed: () async {},
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              ColorsApp.yellow),
                        ),
                        child: Text(
                          'تسجيل دخول',
                          style: TextStyle(
                            color: ColorsApp.black,
                            fontSize: 16.sp,
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
