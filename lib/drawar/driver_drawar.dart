import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logistics/Settings_screen/SettingsScreen.dart';
import 'package:logistics/auth/entity/login_entity.dart';
import 'package:logistics/auth/login.dart';
import 'package:logistics/constants/colors.dart';
import 'package:logistics/constants/dio.dart';
import 'package:logistics/constants/endpoints.dart';
import 'package:logistics/constants/images.dart';
import 'package:logistics/data/prefs/prefs.dart';
import 'package:logistics/drawar/list_tile_drawar.dart';
import 'package:logistics/driver_status/driverStatusScreen.dart';
import 'package:logistics/i18n/strings.g.dart';
import 'package:logistics/orders/active_orders/active_orders.dart';
import 'package:logistics/orders/providers/orders_provider.dart';
import 'package:logistics/profile/entity/profile_entity.dart';
import 'package:logistics/profile/profile_screen.dart';
import 'package:logistics/profile/providers/profile_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DriverDrawar extends ConsumerStatefulWidget {
  const DriverDrawar({Key? key}) : super(key: key);

  @override
  _DriverDrawarState createState() => _DriverDrawarState();
}

class _DriverDrawarState extends ConsumerState<DriverDrawar> {
  late String selectedLanguage = 'English';
  //String userName = "name";
  late String phoneNumber;
  @override
  void initState() {
    _loadUserName();
    super.initState();
  }

  _loadUserName() async {
    final preHelper = ref.read(prefHelperProvider);

    final userName = await preHelper.getProfileEntity()!.userName.toString();
    phoneNumber = preHelper.getProfileEntity()!.phone.toString();
    ref.read(userNameProvider.notifier).update((state) => userName);
  }

  @override
  Widget build(BuildContext context) {
    final ProfileProvider = ref.watch(profileProvider);
    final usernameProvider = ref.watch(userNameProvider).toString();
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
                    backgroundImage: AssetImage(
                      ImageAssets.logo,
                    ),
                    radius: 50.sp,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 8.0.sp),
                    child: Text(
                      usernameProvider,
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
              text: t.orders,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ActiveOrders()));
              },
            ),
            // ListTileDrawar(
            //   icon: Icon(
            //     Icons.assignment_turned_in_outlined,
            //   ),
            //   text: t.CompletedOrder,
            //   onPressed: () {
            //     // Navigator.push(context,
            //     //     MaterialPageRoute(builder: (context) => OrdersDon()));
            //   },
            // ),
            ListTileDrawar(
              icon: Icon(
                Icons.update,
              ),
              text: t.update,
              onPressed: () {
                rresponse(phoneNumber, ref);
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  ref.read(ordersProvider.notifier).getOrders();
                });
              },
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
                              onPressed: () async {
                                SharedPreferences sp =
                                    await SharedPreferences.getInstance();
                                final Prehelper = PrefsHelper(sp);
                                Prehelper.clearUserInfo();
                                LocaleSettings.setLocale(AppLocale.en);
                                // sp.setBool('isLogin', false);
                                print("is login ${Prehelper.getIsLoggedIn}");

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

Future<void> rresponse(phoneNumber, ref) async {
  var data = FormData.fromMap({'phone': '${phoneNumber.toString()}'});
  var response = await ApiService().postData(data, Endpoints.login.toString());
  await _postLoginEntityData(response, ref);
  var responsegetdata =
      await ApiService().getData(Endpoints.getProfile.toString(), ref);
  await _saveProfileEntityData(responsegetdata, ref);
}

Future<void> _saveProfileEntityData(responseData, ref) async {
  final preHelper = ref.read(prefHelperProvider);

  // Assuming the API response contains the ProfileEntity data
  ProfileEntity profileEntity = ProfileEntity.fromJson(responseData);

  // Save ProfileEntity in SharedPreferences
  preHelper.saveProfileEntity(profileEntity);

  // Retrieve and print the saved ProfileEntity
  ProfileEntity? retrievedEntity = preHelper.getProfileEntity();
  print("Saved ProfileEntity Name: ${retrievedEntity?.name}");
  //print("Authorization Token: ${preHelper.getUserToken}");
}

Future<void> _postLoginEntityData(response, ref) async {
  if (response.statusCode == 200) {
    LoginEntity loginEntity = LoginEntity.fromJson(response.data);
    final preHelper = ref.read(prefHelperProvider);

    if (!preHelper.getUserToken.contains("Bearer")) {
      preHelper.setUserToken(loginEntity.accessToken);
    }
    preHelper.saveLoginEntity(loginEntity);
    LoginEntity? infoEntity = preHelper.getLoginEntity();
    // print("1${response.data}");
    print("2${infoEntity!.user.name.toString()}");
    //print("3${preHelper.getUserToken}");
  } else {
    print("4${response.statusMessage}");
  }
}
