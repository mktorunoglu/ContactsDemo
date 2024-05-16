import 'package:dio/dio.dart';

import '../constants/constants.dart';
import '../models/model_response.dart';

class DioHelper {
  DioHelper._init();
  static final DioHelper instance = DioHelper._init();

  final Dio dio = Dio();
  final Map<String, dynamic> queryParameters = {
    "skip": 0,
    "take": 10,
  };
  final Options options = Options(
    headers: {"ApiKey": apiKey},
  );

  Future<ResponseModel> getResponse(Future<Response> function) async {
    try {
      final Response response = await function;
      return ResponseModel.fromJson(response.data);
    } catch (e) {
      print("TEST DioException: $e");
      return ResponseModel(
        success: false,
        messages: [defaultErrorMessage],
      );
    }
  }

  Future<ResponseModel> get(String url) async => await getResponse(
        dio.get(
          url,
          queryParameters: queryParameters,
          options: options,
        ),
      );

  Future<ResponseModel> post(String url, {Object? data}) async =>
      await getResponse(
        dio.post(
          url,
          data: data,
          queryParameters: queryParameters,
          options: options,
        ),
      );

  Future<ResponseModel> put(String url, {Object? data}) async =>
      await getResponse(
        dio.put(
          url,
          data: data,
          queryParameters: queryParameters,
          options: options,
        ),
      );

  Future<ResponseModel> delete(String url, {Object? data}) async =>
      await getResponse(
        dio.delete(
          url,
          data: data,
          queryParameters: queryParameters,
          options: options,
        ),
      );
}
