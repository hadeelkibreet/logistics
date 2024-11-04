import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logistics/SplashPage.dart';
import 'package:logistics/data/prefs/shared_pref_provider.dart';

import 'i18n/strings.g.dart'
    show AppLocaleUtils, LocaleSettings, TranslationProvider;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// Initialize the navigator provider
final navigatorProvider = Provider<NavigatorState>((ref) {
  return navigatorKey.currentState!;
});

class LogisticsApp extends ConsumerStatefulWidget {
  const LogisticsApp({super.key});

  @override
  ConsumerState<LogisticsApp> createState() => _LogisticsAppState();
}

class _LogisticsAppState extends ConsumerState<LogisticsApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        locale: TranslationProvider.of(context).flutterLocale,
        supportedLocales: AppLocaleUtils.supportedLocales,
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: SplashPage(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    initSharedPrefs();
    readForceUpdate();
  }

  void initSharedPrefs() async {
    await ref.read(sharedPrefProvider.future);
  }

  void readForceUpdate() {
    final bool flag = FirebaseRemoteConfig.instance.getBool("forceUpdate");
    print("force update is : $flag");
  }
}
