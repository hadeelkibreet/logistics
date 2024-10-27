import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics/constants/endpoints.dart';
import 'package:logistics/core/network/app_interceptor.dart';
import 'package:logistics/data/prefs/shared_pref_provider.dart';
import 'package:logistics/logistic_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

final apiClientProvider = Provider(
  (ref) => ApiClient(
    baseUrl: Endpoints.baseURL,
    navigator: ref.watch(navigatorProvider),
    sharedPreferences: ref.read(sharedPrefProvider).requireValue,
  ),
);

class ApiClient {
  static const Duration _duration = Duration(seconds: 180);
  final String baseUrl;
  final NavigatorState navigator;
  final SharedPreferences sharedPreferences;
  final Dio _dio;

  ApiClient({
    required this.baseUrl,
    required this.navigator,
    required this.sharedPreferences,
  }) : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            receiveTimeout: _duration,
            connectTimeout: _duration,
            sendTimeout: _duration,
          ),
        ) {
    _dio.interceptors.add(AppInterceptor(navigator, sharedPreferences));
  }

  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final Response response = await _dio.get(
      uri,
      queryParameters: queryParameters,
      options: options,
    );
    return response;
  }

  Future<dynamic> post(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final Response response = await _dio.post(
      uri,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
    return response;
  }
}
