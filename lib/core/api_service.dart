import 'dart:convert';
import 'package:bookshop/core/constants.dart';
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
      final headers = {'Authorization': token};

      final response = await _dio.get(url,
          queryParameters: queryParameters, options: Options(headers: headers));

      if (response.statusCode == 200) {
        final data = fromJson != null
            ? fromJson(json.decode(response.data))
            : json.decode(response.data);
        return DataSuccess<T>(data);
      } else {
        return DataFailed<T>(
          DioException(
            requestOptions: response.requestOptions,
            error: response.statusMessage,
            response: response,
            type: DioExceptionType.badResponse,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed<T>(e);
    } catch (e) {
      return DataFailed<T>(
        DioException(
          requestOptions: RequestOptions(),
          error: e,
          type: DioExceptionType.unknown,
        ),
      );
    }
  }
}
