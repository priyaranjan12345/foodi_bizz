import 'dart:io';

import 'package:dio/dio.dart';

class FoodItemErrorHandler {
  static void onSocketErrorRetry(
    DioError err,
    ErrorInterceptorHandler handler,
    Dio dio,
  ) async {
    var result = await dio.request(
      err.requestOptions.path,
      data: err.requestOptions.data,
      options: Options(
        method: err.requestOptions.method,
        contentType: err.requestOptions.contentType,
        headers: err.requestOptions.headers,
        responseType: err.requestOptions.responseType,
        followRedirects: err.requestOptions.followRedirects,
        validateStatus: err.requestOptions.validateStatus,
        receiveDataWhenStatusError:
            err.requestOptions.receiveDataWhenStatusError,
        extra: err.requestOptions.extra,
        responseDecoder: err.requestOptions.responseDecoder,
        listFormat: err.requestOptions.listFormat,
        maxRedirects: err.requestOptions.maxRedirects,
        receiveTimeout: err.requestOptions.receiveTimeout,
        sendTimeout: err.requestOptions.sendTimeout,
        requestEncoder: err.requestOptions.requestEncoder,
      ),
    );
    handler.resolve(result);
  }

  static void onSocketErrorCancel(
    DioError err,
    ErrorInterceptorHandler handler,
    Dio dio,
  ) async {
    handler.resolve(
      Response(
        data: 'No Internet Connection',
        requestOptions: err.requestOptions,
      ),
    );
  }

  static void handleError(
      DioError err, ErrorInterceptorHandler handler, Dio dio) async {
    try {
      switch (err.type) {
        case DioErrorType.connectTimeout:
          handler.resolve(
            Response(
              data: 'Connect timeout error',
              requestOptions: err.requestOptions,
            ),
          );

          break;
        case DioErrorType.sendTimeout:
          handler.resolve(
            Response(
              data: 'Sending data is slow',
              requestOptions: err.requestOptions,
            ),
          );

          break;
        case DioErrorType.receiveTimeout:
          handler.resolve(
            Response(
              data: 'Receiving data is slow',
              requestOptions: err.requestOptions,
            ),
          );

          break;
        case DioErrorType.response:
          handler.resolve(
            err.response != null
                ? Response(
                    data: err.response!,
                    requestOptions: err.requestOptions,
                  )
                : Response(
                    data: 'Response with incorrect status',
                    requestOptions: err.requestOptions,
                  ),
          );

          break;
        case DioErrorType.cancel:
          handler.resolve(
            Response(
              data: 'Request is cancelled',
              requestOptions: err.requestOptions,
            ),
          );

          break;
        case DioErrorType.other:
          if (err.error is SocketException) {
            // await socketExceptionHandler(err, handler, dio);
            handler.resolve(
              Response(
                data: 'No Internet Connection',
                requestOptions: err.requestOptions,
              ),
            );
          } else {
            handler.resolve(
              Response(
                data: err.message != ''
                    ? err.message
                    : 'Oops something went wrong',
                requestOptions: err.requestOptions,
              ),
            );
          }
          break;
      }
    } catch (_) {
      handler.resolve(
        Response(
          data: err.message != ''
              ? err.message
              : 'Unexpected error, please try again later',
          requestOptions: err.requestOptions,
        ),
      );
    }
  }
}
