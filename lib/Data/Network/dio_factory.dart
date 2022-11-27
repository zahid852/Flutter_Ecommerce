import 'package:dio/dio.dart';
import 'package:ecomerce/App/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String ACCEPT = "accept";
const String CONTENT_TYPE = "content-type";
const String APPLICATION_JSON = "application/json";
const String AUTHORIZATION = "authorization";

class DioFactory {
  Future<Dio> getDio() async {
    Dio dio = Dio();
    // int _timeOut = 60 * 1000; // 1 min

    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORIZATION: 'get api token from here'
    };
    dio.options = BaseOptions(
        baseUrl: constants.baseUrl,
        // connectTimeout: _timeOut,
        // receiveTimeout: _timeOut,
        headers: headers);

    if (kReleaseMode) {
      print("release mode no logs");
    } else {
      dio.interceptors.add(PrettyDioLogger(
          requestHeader: true, requestBody: true, responseHeader: true));
    }
    return dio;
  }
}
