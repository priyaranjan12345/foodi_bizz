import 'dart:developer';

import 'package:dio/dio.dart';

import 'fooditem_error_handler.dart';

class FoodItemInterceptor extends Interceptor {
  Stopwatch? stopwatch;
  late Dio dio;

  FoodItemInterceptor({required this.dio});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('-' * 60);
    log('\x1B[36mRequest url 🙂 : ${options.baseUrl}${options.path}\x1B[0m');
    log('\x1B[36mRequest data 🙂 : ${options.data}\x1B[0m');

    if (options.data is FormData) {
      for (var item in options.data.fields) {
        log('${item.key} : ${item.value}');
      }
    }

    log('-' * 60);

    stopwatch = Stopwatch()..start();

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('\x1B[32mResponse url 😀 : ${response.realUri}\x1B[0m');
    log('\x1B[32mResponse data 😀 : ${response.data}\x1B[0m');
    log('\x1B[34mResponse time 😇 : ${stopwatch!.elapsed}\x1B[0m');
    log('-' * 60);

    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    log('\x1B[31mError type 😧 : ${err.type}\x1B[0m');
    log('\x1B[31mError message 😧 : ${err.message}\x1B[0m');
    log('\x1B[31mError response 😧 : ${err.response}\x1B[0m');
    log('\x1B[34mError Response time 😇 : ${stopwatch!.elapsed}\x1B[0m');
    log('-' * 60);
    FoodItemErrorHandler.handleError(err, handler, dio);
  }
}
