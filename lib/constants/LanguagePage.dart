import 'package:flutter/material.dart';

import '../i18n/strings.g.dart' show Translations, AppLocale, LocaleSettings, t;

class LanguagePage extends StatefulWidget {
  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  @override
  void initState() {
    super.initState();

    LocaleSettings.getLocaleStream().listen((event) {
      print('locale changed: $event');
    });
  }

  @override
  Widget build(BuildContext context) {
    // get t variable, will trigger rebuild on locale change
    // otherwise just call t directly (if locale is not changeable)
    final t = Translations.of(context);
    final AppLocale activeLocale = LocaleSettings.currentLocale;

    return Scaffold(
        appBar: AppBar(
          title: Text(t.hello),
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: activeLocale == AppLocale.ar
                          ? Colors.blue.shade100
                          : null,
                    ),
                    onPressed: () {
                      activeLocale == AppLocale.en
                          ? LocaleSettings.setLocale(AppLocale.ar)
                          : LocaleSettings.setLocale(AppLocale.en);
                    },
                    child: Text(
                      t.hello,
                      style: TextStyle(fontSize: 24.0),
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ));
  }
}
