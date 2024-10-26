/// Generated file. Do not edit.
///
/// Original: lib/i18n
/// To regenerate, run: `dart run slang`
///
/// Locales: 2
/// Strings: 184 (92 per locale)
///
/// Built on 2024-10-16 at 10:55 UTC

// coverage:ignore-file
// ignore_for_file: type=lint

import 'package:flutter/widgets.dart';
import 'package:slang/builder/model/node.dart';
import 'package:slang_flutter/slang_flutter.dart';
export 'package:slang_flutter/slang_flutter.dart';

const AppLocale _baseLocale = AppLocale.en;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale with BaseAppLocale<AppLocale, Translations> {
  en(languageCode: 'en', build: Translations.build),
  ar(languageCode: 'ar', build: _StringsAr.build);

  const AppLocale(
      {required this.languageCode,
      this.scriptCode,
      this.countryCode,
      required this.build}); // ignore: unused_element

  @override
  final String languageCode;
  @override
  final String? scriptCode;
  @override
  final String? countryCode;
  @override
  final TranslationBuilder<AppLocale, Translations> build;

  /// Gets current instance managed by [LocaleSettings].
  Translations get translations =>
      LocaleSettings.instance.translationMap[this]!;
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
/// Configurable via 'translate_var'.
///
/// Usage:
/// String a = t.someKey.anotherKey;
/// String b = t['someKey.anotherKey']; // Only for edge cases!
Translations get t => LocaleSettings.instance.currentTranslations;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final t = Translations.of(context); // Get t variable.
/// String a = t.someKey.anotherKey; // Use t variable.
/// String b = t['someKey.anotherKey']; // Only for edge cases!
class TranslationProvider
    extends BaseTranslationProvider<AppLocale, Translations> {
  TranslationProvider({required super.child})
      : super(settings: LocaleSettings.instance);

  static InheritedLocaleData<AppLocale, Translations> of(
          BuildContext context) =>
      InheritedLocaleData.of<AppLocale, Translations>(context);
}

/// Method B shorthand via [BuildContext] extension method.
/// Configurable via 'translate_var'.
///
/// Usage (e.g. in a widget's build method):
/// context.t.someKey.anotherKey
extension BuildContextTranslationsExtension on BuildContext {
  Translations get t => TranslationProvider.of(this).translations;
}

/// Manages all translation instances and the current locale
class LocaleSettings
    extends BaseFlutterLocaleSettings<AppLocale, Translations> {
  LocaleSettings._() : super(utils: AppLocaleUtils.instance);

  static final instance = LocaleSettings._();

  // static aliases (checkout base methods for documentation)
  static AppLocale get currentLocale => instance.currentLocale;
  static Stream<AppLocale> getLocaleStream() => instance.getLocaleStream();
  static AppLocale setLocale(AppLocale locale,
          {bool? listenToDeviceLocale = false}) =>
      instance.setLocale(locale, listenToDeviceLocale: listenToDeviceLocale);
  static AppLocale setLocaleRaw(String rawLocale,
          {bool? listenToDeviceLocale = false}) =>
      instance.setLocaleRaw(rawLocale,
          listenToDeviceLocale: listenToDeviceLocale);
  static AppLocale useDeviceLocale() => instance.useDeviceLocale();
  @Deprecated('Use [AppLocaleUtils.supportedLocales]')
  static List<Locale> get supportedLocales => instance.supportedLocales;
  @Deprecated('Use [AppLocaleUtils.supportedLocalesRaw]')
  static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
  static void setPluralResolver(
          {String? language,
          AppLocale? locale,
          PluralResolver? cardinalResolver,
          PluralResolver? ordinalResolver}) =>
      instance.setPluralResolver(
        language: language,
        locale: locale,
        cardinalResolver: cardinalResolver,
        ordinalResolver: ordinalResolver,
      );
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, Translations> {
  AppLocaleUtils._()
      : super(baseLocale: _baseLocale, locales: AppLocale.values);

  static final instance = AppLocaleUtils._();

  // static aliases (checkout base methods for documentation)
  static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
  static AppLocale parseLocaleParts(
          {required String languageCode,
          String? scriptCode,
          String? countryCode}) =>
      instance.parseLocaleParts(
          languageCode: languageCode,
          scriptCode: scriptCode,
          countryCode: countryCode);
  static AppLocale findDeviceLocale() => instance.findDeviceLocale();
  static List<Locale> get supportedLocales => instance.supportedLocales;
  static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
}

// translations

// Path: <root>
class Translations implements BaseTranslations<AppLocale, Translations> {
  /// Returns the current translations of the given [context].
  ///
  /// Usage:
  /// final t = Translations.of(context);
  static Translations of(BuildContext context) =>
      InheritedLocaleData.of<AppLocale, Translations>(context).translations;

  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  Translations.build(
      {Map<String, Node>? overrides,
      PluralResolver? cardinalResolver,
      PluralResolver? ordinalResolver})
      : assert(overrides == null,
            'Set "translation_overrides: true" in order to enable this feature.'),
        $meta = TranslationMetadata(
          locale: AppLocale.en,
          overrides: overrides ?? {},
          cardinalResolver: cardinalResolver,
          ordinalResolver: ordinalResolver,
        ) {
    $meta.setFlatMapFunction(_flatMapFunction);
  }

  /// Metadata for the translations of <en>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  /// Access flat map
  dynamic operator [](String key) => $meta.getTranslation(key);

  late final Translations _root = this; // ignore: unused_field

  // Translations
  String get language => 'English';
  String get hello => 'Hello';
  String get EnterAphoneNumber => 'Enter a phone number';
  String get EnterThePassword => 'Enter the password';
  String get LogIn => 'LogIn';
  String get changeToEnglish => 'تغير اللغة الى العربية';
  String get ServiceSchedule => 'Service schedule';
  String get IAmInService => 'I am in service';
  String get IAmInBreak => 'I am in break';
  String get IAmOutOfService => 'I am out of Service';
  String get InService => 'in service';
  String get InBreak => 'in break';
  String get OutOfService => 'out of Service';
  String get orders => 'Orders';
  String get order => 'order';
  String get CompletedOrder => 'Completed Orders';
  String get update => 'Refresh';
  String get MyProfile => 'My profile';
  String get languages => 'languages';
  String get Setting => 'Setting';
  String get ShareTheApp => 'Share Application';
  String get LogOut => 'Logout';
  String get ReleaseThisApplication => 'Release this application';
  String get personalInfo => 'personal information';
  String get dateOfBirth => 'date of birth';
  String get gender => 'gender';
  String get Country => 'Country';
  String get email => 'email';
  String get passWord => 'password';
  String get changeThePassWord => 'Change the password';
  String get alertWithSound => 'New alert With Sound';
  String get alertWithVibrate => 'New alert With Vibrate';
  String get showNotifications => 'show Notifications';
  String get Notifications => 'Notifications';
  String get no => 'no';
  String get yes => 'yes';
  String get AreYouSureToChangeThePassword =>
      'Are you sure to change the password?';
  String get DoYouReallyWantToLogOut => 'Do you really want to log out?';
  String get resident => 'resident';
  String get LoadingTheShipment => 'Loading the shipment';
  String get Start => 'start';
  String get usingTheMap => 'Using the map';
  String get done => 'Done';
  String get delivery => 'delivery';
  String get tryy => 'try';
  String get notTry => 'Not try';
  String get allOrders => 'All orders';
  String get Reloading => 'Reloading';
  String get Search => 'Search';
  String get orderNumber => 'order number:';
  String get accept => 'Accept';
  String get unacceptable => 'unacceptable';
  String get locationUpdateRequest => 'location update request';
  String get theAmountToBeReceived => 'The amount to be received';
  String get additionalDetails => 'Additional details';
  String get tripInformation => 'Trip information';
  String get from => 'from';
  String get to => 'to';
  String get serviceType => 'service type';
  String get deliveryZone => 'Delivery Zone';
  String get dateCreated => 'Date created';
  String get thePeriodOfTimeToCarryTheShipment => 'Cargo carrying time';
  String get packageInformation => 'Package information';
  String get packageType => 'Package type';
  String get description => 'description';
  String get Weight => 'Weight';
  String get Quantity => 'Quantity';
  String get PackagePhoto => 'Package photo';
  String get proofOfDelivery => 'Proof of delivery';
  String get NameOfAddresseeRecipient => 'Name of addressee/recipient';
  String get ProofOfTheRecipientsIdentity => 'Proof of the recipients id';
  String get TheRecipientsSignature => 'The recipients signature';
  String get ConnectionStatus => 'Connection status';
  String get paymentInformation => 'payment information';
  String get PaymentType => 'Payment type';
  String get monetary => 'monetary';
  String get ATM => 'ATM';
  String get PaymentWasMadeVia => 'Payment was made via';
  String get ServiceCost => 'Service cost';
  String get paid => 'paid';
  String get cancel => 'Cancel';
  String get InTheShippingStage => 'In the shipping stage';
  String get clear => 'clear';
  String get openCamera => 'open camera';
  String get RequestADeliveryLocation => 'Request a delivery location';
  String get Failed => 'Failed';
  String get Done => 'Done';
  String get SendersName => 'Sender\'s name';
  String get SendersID => 'Sender\'s ID';
  String get Upload => 'Upload';
  String get phoneNumber => 'Phone number';
  String get AirWaybillNumber => 'Air waybill number';
  String get sendersSignature => 'Sender\'s signature';
  String get Save => 'Save';
  String get comment => 'comment';
  String get View => 'View';
}

// Path: <root>
class _StringsAr implements Translations {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  _StringsAr.build(
      {Map<String, Node>? overrides,
      PluralResolver? cardinalResolver,
      PluralResolver? ordinalResolver})
      : assert(overrides == null,
            'Set "translation_overrides: true" in order to enable this feature.'),
        $meta = TranslationMetadata(
          locale: AppLocale.ar,
          overrides: overrides ?? {},
          cardinalResolver: cardinalResolver,
          ordinalResolver: ordinalResolver,
        ) {
    $meta.setFlatMapFunction(_flatMapFunction);
  }

  /// Metadata for the translations of <ar>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  /// Access flat map
  @override
  dynamic operator [](String key) => $meta.getTranslation(key);

  @override
  late final _StringsAr _root = this; // ignore: unused_field

  // Translations
  @override
  String get language => 'عربي';
  @override
  String get hello => 'مرحبا';
  @override
  String get EnterAphoneNumber => 'ادخل رقم الهاتف';
  @override
  String get EnterThePassword => 'ادخل كلمة المرور';
  @override
  String get LogIn => 'تسجيل الدخول';
  @override
  String get changeToEnglish => 'change to English';
  @override
  String get ServiceSchedule => 'جدول الخدمة';
  @override
  String get IAmInService => 'أنا في الخدمة';
  @override
  String get IAmInBreak => 'أنا في استراحة';
  @override
  String get IAmOutOfService => 'أنا خارج الخدمة';
  @override
  String get InService => 'في الخدمة';
  @override
  String get InBreak => 'في استراحة';
  @override
  String get OutOfService => 'خارج الخدمة';
  @override
  String get order => 'الطلب';
  @override
  String get orders => 'الطلبات';
  @override
  String get CompletedOrder => 'أكتمل';
  @override
  String get update => 'تحديث الدفعة';
  @override
  String get MyProfile => 'ملفي';
  @override
  String get languages => 'اللغات';
  @override
  String get Setting => 'الإعدادات';
  @override
  String get ShareTheApp => 'شارك هذا التطبيق';
  @override
  String get LogOut => 'تسجيل خروج';
  @override
  String get ReleaseThisApplication => 'اصدار هذا التطبيق';
  @override
  String get personalInfo => 'معلومات شخصية';
  @override
  String get dateOfBirth => 'تاريخ الميلاد';
  @override
  String get gender => 'الجنس';
  @override
  String get Country => 'البلد';
  @override
  String get email => 'البريد الالكتروني';
  @override
  String get passWord => 'كلمةالمرور';
  @override
  String get changeThePassWord => 'تغير كلمة السر';
  @override
  String get alertWithSound => 'تنبيه جديد عن طريق الاهتزاز';
  @override
  String get alertWithVibrate => 'تنبيه جديد عن طريق الصوت';
  @override
  String get showNotifications => 'إخطار الرسائل القصيرة';
  @override
  String get Notifications => 'الإشعارات';
  @override
  String get no => 'لا';
  @override
  String get yes => 'نعم';
  @override
  String get AreYouSureToChangeThePassword =>
      'هل انت متاكد من تغير كلمة المرور؟';
  @override
  String get DoYouReallyWantToLogOut => 'هل فعلا تريد تغير كلمة المرور؟';
  @override
  String get resident => 'مقيم';
  @override
  String get LoadingTheShipment => 'تحميل الشحنة';
  @override
  String get Start => 'ابدأ';
  @override
  String get usingTheMap => 'إستخدم الخريطة';
  @override
  String get done => 'تم التوصيل';
  @override
  String get delivery => 'توصيل';
  @override
  String get tryy => 'حاول';
  @override
  String get notTry => 'غير محاول';
  @override
  String get allOrders => 'جميع الطلبات';
  @override
  String get Reloading => 'إعادة التحميل';
  @override
  String get Search => 'بحث';
  @override
  String get orderNumber => 'رقم الطلب :';
  @override
  String get accept => 'تم القبول';
  @override
  String get unacceptable => 'تم الرفض';
  @override
  String get locationUpdateRequest => 'طلب تحديث الموقع';
  @override
  String get theAmountToBeReceived => 'المبلغ المطلوب إستلامه';
  @override
  String get additionalDetails => 'تفاصيل إضافية';
  @override
  String get tripInformation => 'معلومات الرحلة';
  @override
  String get from => 'من';
  @override
  String get to => 'إلى';
  @override
  String get serviceType => 'نوع الخدمة';
  @override
  String get dateCreated => 'تاريخ الإنشاء';
  @override
  String get thePeriodOfTimeToCarryTheShipment => 'فترة الوقت لحمل الشحنة';
  @override
  String get packageInformation => 'معلومات الطرد';
  @override
  String get packageType => 'نوع الطرد';
  @override
  String get description => 'الوصف';
  @override
  String get PackagePhoto => 'صورة الطرد';
  @override
  String get proofOfDelivery => 'إثبات التوصيل';
  @override
  String get NameOfAddresseeRecipient => 'اسم المرسل إليه / المستلم';
  @override
  String get ProofOfTheRecipientsIdentity => 'إثبات هوية المستلم';
  @override
  String get TheRecipientsSignature => 'توقيع المستلم';
  @override
  String get ConnectionStatus => 'حاله  التوصيل';
  @override
  String get paymentInformation => 'معلومات الدفع';
  @override
  String get PaymentType => 'نوع الدفع';
  @override
  String get monetary => 'نقدي';
  @override
  String get ATM => 'بطاقة البنك';
  @override
  String get PaymentWasMadeVia => 'تم الدفع عن طريق';
  @override
  String get ServiceCost => 'تكلفة الخدمة';
  @override
  String get paid => 'مدفوع';
  @override
  String get cancel => 'رفض';
  @override
  String get InTheShippingStage => 'في مرحلة الشحن';
  @override
  String get clear => 'مسح';
  @override
  String get openCamera => 'إلتقط صورة';
  @override
  String get RequestADeliveryLocation => 'طلب موقع التسليم';
  @override
  String get Failed => 'فشلت';
  @override
  String get Done => 'تم';
  @override
  String get SendersName => 'أسم المرسل';
  @override
  String get SendersID => 'إثبات المرسل';
  @override
  String get Upload => 'تحميل';
  @override
  String get phoneNumber => 'رقم الهاتف';
  @override
  String get AirWaybillNumber => 'رقم بوليصة الشحن الجوي';
  @override
  String get sendersSignature => 'توقيع المرسل';
  @override
  String get Save => 'حفظ';
  @override
  String get comment => 'تعليق';
  @override
  String get View => 'عرض';

  @override
  String get Quantity => 'العدد';

  @override
  String get Weight => 'الوزن';

  @override
  String get deliveryZone => 'منطقة التوصيل';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on Translations {
  dynamic _flatMapFunction(String path) {
    switch (path) {
      case 'language':
        return 'English';
      case 'hello':
        return 'Hello';
      case 'EnterAphoneNumber':
        return 'Enter a phone number';
      case 'EnterThePassword':
        return 'Enter the password';
      case 'LogIn':
        return 'LogIn';
      case 'changeToEnglish':
        return 'تغير اللغة الى العربية';
      case 'ServiceSchedule':
        return 'Service schedule';
      case 'IAmInService':
        return 'I am in service';
      case 'IAmInBreak':
        return 'I am in break';
      case 'IAmOutOfService':
        return 'I am out of Service';
      case 'InService':
        return 'in service';
      case 'InBreak':
        return 'in break';
      case 'OutOfService':
        return 'out of Service';
      case 'orders':
        return 'Orders';
      case 'order':
        return 'order';
      case 'CompletedOrder':
        return 'Completed Orders';
      case 'update':
        return 'Update';
      case 'MyProfile':
        return 'My profile';
      case 'languages':
        return 'languages';
      case 'Setting':
        return 'Setting';
      case 'ShareTheApp':
        return 'Share Application';
      case 'LogOut':
        return 'Logout';
      case 'ReleaseThisApplication':
        return 'Release this application';
      case 'personalInfo':
        return 'personal information';
      case 'dateOfBirth':
        return 'date of birth';
      case 'gender':
        return 'gender';
      case 'Country':
        return 'Country';
      case 'email':
        return 'email';
      case 'passWord':
        return 'password';
      case 'changeThePassWord':
        return 'Change the password';
      case 'alertWithSound':
        return 'New alert With Sound';
      case 'alertWithVibrate':
        return 'New alert With Vibrate';
      case 'showNotifications':
        return 'show Notifications';
      case 'Notifications':
        return 'Notifications';
      case 'no':
        return 'no';
      case 'yes':
        return 'yes';
      case 'AreYouSureToChangeThePassword':
        return 'Are you sure to change the password?';
      case 'DoYouReallyWantToLogOut':
        return 'Do you really want to log out?';
      case 'resident':
        return 'resident';
      case 'LoadingTheShipment':
        return 'Loading the shipment';
      case 'Start':
        return 'start';
      case 'usingTheMap':
        return 'Using the map';
      case 'done':
        return 'Done';
      case 'delivery':
        return 'delivery';
      case 'tryy':
        return 'try';
      case 'notTry':
        return 'Not try';
      case 'allOrders':
        return 'All orders';
      case 'Reloading':
        return 'Reloading';
      case 'Search':
        return 'Search';
      case 'orderNumber':
        return 'order number:';
      case 'accept':
        return 'Accept';
      case 'unacceptable':
        return 'unacceptable';
      case 'locationUpdateRequest':
        return 'location update request';
      case 'theAmountToBeReceived':
        return 'The amount to be received';
      case 'additionalDetails':
        return 'Additional details';
      case 'tripInformation':
        return 'Trip information';
      case 'from':
        return 'from';
      case 'to':
        return 'to';
      case 'serviceType':
        return 'service type';
      case 'dateCreated':
        return 'Date created';
      case 'thePeriodOfTimeToCarryTheShipment':
        return 'Cargo carrying time';
      case 'packageInformation':
        return 'Package information';
      case 'packageType':
        return 'Package type';
      case 'description':
        return 'description';
      case 'PackagePhoto':
        return 'Package photo';
      case 'proofOfDelivery':
        return 'Proof of delivery';
      case 'NameOfAddresseeRecipient':
        return 'Name of addressee/recipient';
      case 'ProofOfTheRecipientsIdentity':
        return 'Proof of the recipients id';
      case 'TheRecipientsSignature':
        return 'The recipients signature';
      case 'ConnectionStatus':
        return 'Connection status';
      case 'paymentInformation':
        return 'payment information';
      case 'PaymentType':
        return 'Payment type';
      case 'monetary':
        return 'monetary';
      case 'ATM':
        return 'ATM';
      case 'PaymentWasMadeVia':
        return 'Payment was made via';
      case 'ServiceCost':
        return 'Service cost';
      case 'paid':
        return 'paid';
      case 'cancel':
        return 'Cancel';
      case 'InTheShippingStage':
        return 'In the shipping stage';
      case 'clear':
        return 'clear';
      case 'openCamera':
        return 'open camera';
      case 'RequestADeliveryLocation':
        return 'Request a delivery location';
      case 'Failed':
        return 'Failed';
      case 'Done':
        return 'Done';
      case 'SendersName':
        return 'Sender\'s name';
      case 'SendersID':
        return 'Sender\'s ID';
      case 'Upload':
        return 'Upload';
      case 'phoneNumber':
        return 'Phone number';
      case 'AirWaybillNumber':
        return 'Air waybill number';
      case 'sendersSignature':
        return 'Sender\'s signature';
      case 'Save':
        return 'Save';
      case 'comment':
        return 'comment';
      case 'view':
        return 'View';
      default:
        return null;
    }
  }
}

extension on _StringsAr {
  dynamic _flatMapFunction(String path) {
    switch (path) {
      case 'language':
        return 'عربي';
      case 'hello':
        return 'مرحبا';
      case 'EnterAphoneNumber':
        return 'ادخل رقم الهاتف';
      case 'EnterThePassword':
        return 'ادخل كلمة المرور';
      case 'LogIn':
        return 'تسجيل الدخول';
      case 'changeToEnglish':
        return 'change to English';
      case 'ServiceSchedule':
        return 'جدول الخدمة';
      case 'IAmInService':
        return 'أنا في الخدمة';
      case 'IAmInBreak':
        return 'أنا في استراحة';
      case 'IAmOutOfService':
        return 'أنا خارج الخدمة';
      case 'InService':
        return 'في الخدمة';
      case 'InBreak':
        return 'في استراحة';
      case 'OutOfService':
        return 'خارج الخدمة';
      case 'order':
        return 'الطلب';
      case 'orders':
        return 'الطلبات';
      case 'CompletedOrder':
        return 'أكتمل';
      case 'update':
        return 'تحديث الدفعة';
      case 'MyProfile':
        return 'ملفي';
      case 'languages':
        return 'اللغات';
      case 'Setting':
        return 'الإعدادات';
      case 'ShareTheApp':
        return 'شارك هذا التطبيق';
      case 'LogOut':
        return 'تسجيل خروج';
      case 'ReleaseThisApplication':
        return 'اصدار هذا التطبيق';
      case 'personalInfo':
        return 'معلومات شخصية';
      case 'dateOfBirth':
        return 'تاريخ الميلاد';
      case 'gender':
        return 'الجنس';
      case 'Country':
        return 'البلد';
      case 'email':
        return 'البريد الالكتروني';
      case 'passWord':
        return 'كلمةالمرور';
      case 'changeThePassWord':
        return 'تغير كلمة السر';
      case 'alertWithSound':
        return 'تنبيه جديد عن طريق الاهتزاز';
      case 'alertWithVibrate':
        return 'تنبيه جديد عن طريق الصوت';
      case 'showNotifications':
        return 'إخطار الرسائل القصيرة';
      case 'Notifications':
        return 'الإشعارات';
      case 'no':
        return 'لا';
      case 'yes':
        return 'نعم';
      case 'AreYouSureToChangeThePassword':
        return 'هل انت متاكد من تغير كلمة المرور؟';
      case 'DoYouReallyWantToLogOut':
        return 'هل فعلا تريد تغير كلمة المرور؟';
      case 'resident':
        return 'مقيم';
      case 'LoadingTheShipment':
        return 'تحميل الشحنة';
      case 'Start':
        return 'ابدأ';
      case 'usingTheMap':
        return 'إستخدم الخريطة';
      case 'done':
        return 'تم التوصيل';
      case 'delivery':
        return 'توصيل';
      case 'tryy':
        return 'حاول';
      case 'notTry':
        return 'غير محاول';
      case 'allOrders':
        return 'جميع الطلبات';
      case 'Reloading':
        return 'إعادة التحميل';
      case 'Search':
        return 'بحث';
      case 'orderNumber':
        return 'رقم الطلب :';
      case 'accept':
        return 'تم القبول';
      case 'unacceptable':
        return 'تم الرفض';
      case 'locationUpdateRequest':
        return 'طلب تحديث الموقع';
      case 'theAmountToBeReceived':
        return 'المبلغ المطلوب إستلامه';
      case 'additionalDetails':
        return 'تفاصيل إضافية';
      case 'tripInformation':
        return 'معلومات الرحلة';
      case 'from':
        return 'من';
      case 'to':
        return 'إلى';
      case 'serviceType':
        return 'نوع الخدمة';
      case 'dateCreated':
        return 'تاريخ الإنشاء';
      case 'thePeriodOfTimeToCarryTheShipment':
        return 'فترة الوقت لحمل الشحنة';
      case 'packageInformation':
        return 'معلومات الطرد';
      case 'packageType':
        return 'نوع الطرد';
      case 'description':
        return 'الوصف';
      case 'PackagePhoto':
        return 'صورة الطرد';
      case 'proofOfDelivery':
        return 'إثبات التوصيل';
      case 'NameOfAddresseeRecipient':
        return 'اسم المرسل إليه / المستلم';
      case 'ProofOfTheRecipientsIdentity':
        return 'إثبات هوية المستلم';
      case 'TheRecipientsSignature':
        return 'توقيع المستلم';
      case 'ConnectionStatus':
        return 'حاله  التوصيل';
      case 'paymentInformation':
        return 'معلومات الدفع';
      case 'PaymentType':
        return 'نوع الدفع';
      case 'monetary':
        return 'نقدي';
      case 'ATM':
        return 'بطاقة البنك';
      case 'PaymentWasMadeVia':
        return 'تم الدفع عن طريق';
      case 'ServiceCost':
        return 'تكلفة الخدمة';
      case 'paid':
        return 'مدفوع';
      case 'cancel':
        return 'رفض';
      case 'InTheShippingStage':
        return 'في مرحلة الشحن';
      case 'clear':
        return 'مسح';
      case 'openCamera':
        return 'إلتقط صورة';
      case 'RequestADeliveryLocation':
        return 'طلب موقع التسليم';
      case 'Failed':
        return 'فشلت';
      case 'Done':
        return 'تم';
      case 'SendersName':
        return 'أسم المرسل';
      case 'SendersID':
        return 'إثبات المرسل';
      case 'Upload':
        return 'تحميل';
      case 'phoneNumber':
        return 'رقم الهاتف';
      case 'AirWaybillNumber':
        return 'رقم بوليصة الشحن الجوي';
      case 'sendersSignature':
        return 'توقيع المرسل';
      case 'Save':
        return 'حفظ';
      case 'comment':
        return 'تعليق';
      default:
        return null;
    }
  }
}
