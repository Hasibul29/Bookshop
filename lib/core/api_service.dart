import 'dart:io';

import 'package:dio/dio.dart';

import 'datastate.dart';

class ApiService {
  final Dio _dio;

  ApiService() : _dio = Dio();

  Future<DataState<T>> getRequest<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await _dio.get(url, queryParameters: queryParameters);

      if (response.statusCode == HttpStatus.ok) {
        final data =
            fromJson != null ? fromJson(response.data) : response.data as T;
        return DataSuccess(data);
      } else {
        return DataFailed(
          DioException(
            requestOptions: response.requestOptions,
            error: response.statusMessage,
            response: response,
            type: DioExceptionType.badResponse,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
