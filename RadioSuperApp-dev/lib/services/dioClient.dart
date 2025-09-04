import 'package:dio/dio.dart';
import 'apiEndpoints.dart';

class DioClient {
  final Dio _dio = Dio();

  DioClient() {
    _dio.options.baseUrl = ApiEndpoints.devBaseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 50); // 10 seconds
    _dio.options.receiveTimeout = const Duration(seconds: 50);

    // You can add interceptors here for logging, authentication, etc.
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Add headers or perform actions before request is sent
        return handler.next(options);
      },
      onResponse: (response, handler) {
        // Handle response data
        return handler.next(response);
      },
      onError: (DioException e, handler) async {
        return handler.reject(e);
      },
    ));
  }

  Dio get dio => _dio;
}