import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constantes.dart';

class CustomDio {
  var _dio;

  CustomDio() {
    _dio = Dio();
  }

  CustomDio.withAuthentication() {
    _dio = Dio();
    _dio.interceptors.add(InterceptorsWrapper(
        onRequest: _onRequest, onResponse: _onRespose, onError: _onError));
  }

  Dio get instance => _dio;

  void _onRequest(
      RequestOptions options, RequestInterceptorHandler interceptor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get(kAPI_Chave_Usuario);
    options.headers['Authorization'] = token;
  }

  _onError(DioError e, ErrorInterceptorHandler interceptor) {
    return e;
  }

  _onRespose(Response e, ResponseInterceptorHandler interceptor) {
    if (kDebugMode) {
      print('########### Response Log');
      print(e.data);
      print('########### Response Log');
    }
  }
}
