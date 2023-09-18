// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';

// class DioInterCeptors extends Interceptor {
//   @override
//   onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');

//     ///example
//     options.headers["lang"] = "en";
//     options.headers["token"] = "token";
//     options.headers["content-type"] = "Applicaton/json";

//     return super.onRequest(options, handler);
//   }

//   @override
//   onResponse(Response response, ResponseInterceptorHandler handler) {
//     debugPrint(
//         'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
//     return super.onResponse(response, handler);
//   }

//   @override
//   onError(DioError err, ErrorInterceptorHandler handler) {
//     debugPrint(
//         'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
//     return super.onError(err, handler);
//   }
// }
