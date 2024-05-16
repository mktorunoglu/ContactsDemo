import 'package:dio/dio.dart';

import '../constants/constants.dart';
import '../models/model_response.dart';

class DioHelper {
  DioHelper._init();
  static final DioHelper instance = DioHelper._init();

  final Dio dio = Dio()..options.headers.addAll({"ApiKey": apiKey});

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

  Future<ResponseModel> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async =>
      await getResponse(
        dio.get(url, queryParameters: queryParameters),
      );

  Future<ResponseModel> post(
    String url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async =>
      await getResponse(
        dio.post(url, data: data, queryParameters: queryParameters),
      );

  Future<ResponseModel> put(
    String url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async =>
      await getResponse(
        dio.put(url, data: data, queryParameters: queryParameters),
      );

  Future<ResponseModel> delete(
    String url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async =>
      await getResponse(
        dio.delete(url, data: data, queryParameters: queryParameters),
      );

  Future<FormData> getFormDataFromImageFilePath(String imageFilePath) async =>
      FormData.fromMap({
        "image": await MultipartFile.fromFile(
          imageFilePath,
          filename: imageFilePath.split('/').last,
        ),
      });
}
