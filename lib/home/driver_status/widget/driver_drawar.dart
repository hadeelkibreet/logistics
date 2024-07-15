import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logistics/auth/login.dart';
import 'package:logistics/constants/colors.dart';
import 'package:logistics/constants/images.dart';
import 'package:logistics/home/Settings_screen/SettingsScreen.dart';
import 'package:logistics/home/driver_status/driverStatusScreen.dart';
import 'package:logistics/home/driver_status/widget/list_tile_drawar.dart';
import 'package:logistics/home/profile/profile_screen.dart';
import 'package:logistics/i18n/strings.g.dart';

class DriverDrawar extends StatefulWidget {
  const DriverDrawar({Key? key}) : super(key: key);

  @override
  State<DriverDrawar> createState() => _DriverDrawarState();
}

class _DriverDrawarState extends State<DriverDrawar> {
  late String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              margin: EdgeInsets.all(0.2.sp),
              decoration: BoxDecoration(
                color: ColorsApp.primaryColor,
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpd4mJRIUwqgE8D_Z2znANEbtiz4GhI4M8NQ&s',
                    ),
                    radius: 50.sp,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 8.0.sp),
                    child: Text(
                      "name",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ColorsApp.white,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTileDrawar(
              icon: Icon(
                Icons.home,
              ),
              text: t.ServiceSchedule,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DriverStatusScreen()),
                );
              },
            ),
            ListTileDrawar(
              icon: Icon(Icons.assignment_outlined),
              text: t.order,
              onPressed: () {},
            ),
            ListTileDrawar(
              icon: Icon(
                Icons.assignment_turned_in_outlined,
              ),
              text: t.CompletedOrder,
              onPressed: () {},
            ),
            ListTileDrawar(
              icon: Icon(
                Icons.update,
              ),
              text: t.update,
              onPressed: () {},
            ),
            Divider(color: ColorsApp.primaryColor),
            ListTileDrawar(
              icon: Icon(
                Icons.person,
              ),
              text: t.MyProfile,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
            ),
            ListTileDrawar(
              icon: Icon(
                Icons.language,
              ),
              text: t.languages,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Column(
                        children: [
                          Text(
                            'اختر اللغة/Selected Language',
                            style: TextStyle(fontSize: 18.sp),
                          ),
                          RadioListTile(
                            title: Text(
                              'الانجليزية/English',
                              style: TextStyle(fontSize: 12.sp),
                            ),
                            value: 'English',
                            secondary: Image.asset(
                              ImageAssets.usa,
                              width: 35.w,
                              height: 35.h,
                            ),
                            groupValue: selectedLanguage,
                            onChanged: (value) {
                              setState(() {
                                selectedLanguage = value!;
                                LocaleSettings.setLocale(AppLocale.en);
                              });
                            },
                          ),
                          RadioListTile(
                            title: Text(
                              'العربية/Arabic',
                              style: TextStyle(fontSize: 12.sp),
                            ),
                            value: 'Arabic',
                            secondary: Image.asset(
                              ImageAssets.ksa,
                              width: 35.w,
                              height: 35.h,
                            ),
                            groupValue: selectedLanguage,
                            onChanged: (value) {
                              setState(() {
                                selectedLanguage = value!;
                                LocaleSettings.setLocale(AppLocale.ar);
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            Divider(color: ColorsApp.primaryColor),
            ListTileDrawar(
              icon: Icon(
                Icons.settings,
              ),
              text: t.Setting,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsScreen()));
              },
            ),
            ListTileDrawar(
              icon: Icon(
                Icons.share,
              ),
              text: t.ShareTheApp,
              onPressed: () {},
            ),
            Divider(color: ColorsApp.primaryColor),
            ListTileDrawar(
              icon: Icon(
                Icons.power_settings_new,
                color: Colors.red,
              ),
              text: t.LogOut,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: ColorsApp.white,
                      title: Column(
                        children: [
                          Icon(
                            Icons.power_settings_new,
                            color: Colors.red,
                            size: 45.sp,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            t.AreYouSureToChangeThePassword,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 13.sp,
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                t.no,
                                style: TextStyle(
                                  color: ColorsApp.primaryColor,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LogInScreen()),
                                  (route) => false,
                                );
                              },
                              child: Text(
                                t.yes,
                                style: TextStyle(
                                  color: ColorsApp.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            Center(
              child: Text(
                t.ReleaseThisApplication,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
