import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logistics/auth/login.dart';
import 'package:logistics/core/network/exceptions/exceptions.dart';
import 'package:logistics/data/prefs/prefs.dart';
import 'package:logistics/i18n/strings.g.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppInterceptor extends QueuedInterceptorsWrapper {
  final NavigatorState navigator;
  final SharedPreferences sharedPreferences;
  AppInterceptor(this.navigator, this.sharedPreferences);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    late final DioException dioException;
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        dioException = ConnectionTimeoutException(
          err.requestOptions,
          err.message,
        );
        break;
      case DioExceptionType.sendTimeout:
        dioException = SendTimeoutException(
          err.requestOptions,
          err.message,
        );
        break;
      case DioExceptionType.receiveTimeout:
        dioException = ReceiveTimeoutException(
          err.requestOptions,
          err.message,
        );
        break;
      case DioExceptionType.badCertificate:
        dioException = BadCertificateException(
          err.requestOptions,
          err.message,
        );
        break;
      case DioExceptionType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
            dioException = BadRequestException(
              err.requestOptions,
              err.message,
            );
            break;
          case 401:
            _handleInvalidToken(err, handler);
            dioException = UnauthorizedException(
              err.requestOptions,
              err.message,
            );
            return;
          case 404:
            dioException = NotFoundException(
              err.requestOptions,
              err.message,
            );
            break;
          case 409:
            dioException = ConflictException(
              err.requestOptions,
              err.message,
            );
            break;

          case 422:
            dioException = ConflictException(
              err.requestOptions,
              err.message,
            );
            break;
          case 500:
            dioException = InternalServerErrorException(
              err.requestOptions,
              err.message,
            );
            break;

          default:
            dioException = BadResponseException(
              err.requestOptions,
              err.message,
            );
        }
        break;

      case DioExceptionType.cancel:
        dioException = CancelException(
          err.requestOptions,
          err.message,
        );
        break;
      case DioExceptionType.connectionError:
        dioException = ConnectionErrorException(
          err.requestOptions,
          err.message,
        );
        break;
      case DioExceptionType.unknown:
        dioException = UnknownException(
          err.requestOptions,
          err.message,
        );
        break;
      default:
        return handler.next(err);
    }
    return handler.next(dioException);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    //read token
    final PrefsHelper prefsHelper = PrefsHelper(sharedPreferences);
    //assign token
    options.headers
        .addAll({'Authorization': "Bearer ${prefsHelper.getUserToken}"});
    //next
    return handler.next(options);
  }

  void _handleInvalidToken(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    final PrefsHelper prefsHelper = PrefsHelper(sp);
    prefsHelper.clearUserInfo();
    LocaleSettings.setLocale(AppLocale.en);
    navigator.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LogInScreen()),
      (route) => false,
    );
    //next
  }
}
