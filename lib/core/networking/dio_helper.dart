import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:news_app/core/networking/api_endpoints.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHelper {
  static Dio? dio;

  static initDio() {
    dio ??= Dio(BaseOptions(baseUrl: ApiEndpoints.baseUrl));
    dio!.interceptors.add(PrettyDioLogger());
  }

  static getRequest({
    required String endPoints,
    Map<String, dynamic>? query,
  }) async {
    try {
      Response response = await dio!.get(endPoints, queryParameters: query);
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  static postRequest({
    required String endPoints,
    Map<String, dynamic>? data,
  }) async {
    try {
      Response response = await dio!.post(endPoints, data: data);
      return response;
    } catch (e) {
      log(e.toString());
    }
  }
}
