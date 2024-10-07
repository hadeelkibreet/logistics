import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logistics/constants/colors.dart';
import 'package:logistics/drawar/driver_drawar.dart';
import 'package:logistics/driver_status/providers/drive_status_provider.dart';
import 'package:logistics/i18n/strings.g.dart';

class DriverStatusScreen extends ConsumerStatefulWidget {
  const DriverStatusScreen({Key? key}) : super(key: key);

  @override
  _DriverStatusScreenState createState() => _DriverStatusScreenState();
}

class _DriverStatusScreenState extends ConsumerState<DriverStatusScreen> {
  bool isServes = false;
  bool inBrack = false;
  bool inOut = false;
  Color borderColor1 = Colors.grey[300]!;
  Color borderColor2 = Colors.grey[300]!;
  Color borderColor3 = Colors.grey[300]!;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final AppLocale activeLocale = LocaleSettings.currentLocale;

    final driverStatusAsync = ref.watch(driverStatusProvider);

    return Scaffold(
      backgroundColor: ColorsApp.backgroundColor,
      drawer: DriverDrawar(),
      appBar: AppBar(
        title: Text(t.ServiceSchedule),
        centerTitle: true,
      ),
      body: driverStatusAsync.when(
        data: (driverStatus) {
          return Column(
            children: [
              Container(
                width: double.infinity,
                color: driverStatus.isActive == 1
                    ? Colors.green
                    : driverStatus.isActive == 2
                        ? Colors.amber
                        : driverStatus.isActive == 3
                            ? Colors.red
                            : Colors.grey,
                padding: EdgeInsets.all(10.0.sp),
                child: Text(
                  "${driverStatus.isActive == 1 ? t.InService : driverStatus.isActive == 2 ? t.InBreak : t.OutOfService}",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 18.sp),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(16.0.sp),
                  children: [
                    buildStatusOption(
                      icon: Icons.check_circle,
                      iconColor: Colors.green,
                      text: t.IAmInService,
                      borderColor: borderColor1,
                      iconBgColor: Colors.grey[300]!,
                      NumberOfser: 1,
                      isServes: isServes,
                      inBrack: inBrack,
                      inOut: inOut,
                      onPressed: () {
                        setState(() {
                          isServes = true;
                          inBrack = false;
                          inOut = false;
                          borderColor1 = Colors.green;
                          borderColor2 = Colors.grey[300]!;
                          borderColor3 = Colors.grey[300]!;
                        });
                      },
                    ),
                    SizedBox(height: 15.h),
                    buildStatusOption(
                      icon: Icons.free_breakfast,
                      iconColor: Colors.orange,
                      text: t.IAmInBreak,
                      borderColor: borderColor2,
                      iconBgColor: Colors.grey[300]!,
                      NumberOfser: 2,
                      isServes: isServes,
                      inBrack: inBrack,
                      inOut: inOut,
                      onPressed: () {
                        setState(() {
                          isServes = false;
                          inBrack = true;
                          inOut = false;
                          borderColor1 = Colors.grey[300]!;
                          borderColor2 = Colors.amber;
                          borderColor3 = Colors.grey[300]!;
                        });
                      },
                    ),
                    SizedBox(height: 15.h),
                    buildStatusOption(
                      icon: Icons.cancel,
                      iconColor: Colors.red,
                      text: t.IAmOutOfService,
                      borderColor: borderColor3,
                      iconBgColor: Colors.red[100]!,
                      textColor: Colors.black,
                      NumberOfser: 3,
                      isServes: isServes,
                      inBrack: inBrack,
                      inOut: inOut,
                      onPressed: () {
                        setState(() {
                          isServes = false;
                          inBrack = false;
                          inOut = true;
                          borderColor1 = Colors.grey[300]!;
                          borderColor2 = Colors.grey[300]!;
                          borderColor3 = Colors.red;
                        });
                      },
                    ),
                    SizedBox(height: 15.h),
                    Container(
                      width: 10.w,
                      height: 40.h,
                      child: ElevatedButton(
                          onPressed: () async {
                            activeLocale == AppLocale.en
                                ? LocaleSettings.setLocale(AppLocale.ar)
                                : LocaleSettings.setLocale(AppLocale.en);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                ColorsApp.yellow),
                          ),
                          child: Text(
                            '${t.changeToEnglish}',
                            style: TextStyle(
                              color: ColorsApp.black,
                              fontSize: 16.sp,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () =>
            Center(child: CircularProgressIndicator()), // Show loading spinner
        error: (error, stack) =>
            Center(child: Text('Error: $error')), // Handle errors
      ),
    );
  }

  Widget buildStatusOption({
    required IconData icon,
    required Color iconColor,
    required String text,
    required Color borderColor,
    required Color iconBgColor,
    required int NumberOfser,
    required bool isServes,
    required bool inBrack,
    required bool inOut,
    Color textColor = Colors.black,
    required VoidCallback onPressed,
  }) {
    Color optionBgColor = Colors.white;

    if (NumberOfser == 1 && isServes) {
      optionBgColor = Colors.green;
    } else if (NumberOfser == 2 && inBrack) {
      optionBgColor = Colors.orange;
    } else if (NumberOfser == 3 && inOut) {
      optionBgColor = Colors.red;
    }

    return Container(
      decoration: BoxDecoration(
        color: optionBgColor,
        borderRadius: BorderRadius.circular(12.0.sp),
      ),
      padding: EdgeInsets.all(12.0.sp),
      child: GestureDetector(
        onTap: onPressed,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.0.sp),
              decoration: BoxDecoration(
                color: iconBgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 24.sp),
            ),
            SizedBox(width: 16.w),
            Text(
              text,
              style: TextStyle(color: textColor, fontSize: 16.sp),
            ),
          ],
        ),
      ),
    );
  }
}
