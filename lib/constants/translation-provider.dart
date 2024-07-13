import 'package:flutter/material.dart';

class TranslationProvider extends InheritedWidget {
  final Locale locale;

  TranslationProvider({
    Key? key,
    required this.locale,
    required Widget child,
  }) : super(key: key, child: child);

  static TranslationProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TranslationProvider>();
  }

  @override
  bool updateShouldNotify(TranslationProvider oldWidget) {
    return oldWidget.locale != locale;
  }
}
