import '../models/model_response.dart';

abstract class IUser {
  Future<ResponseModel> getAllUsers({
    required int skip,
    required int take,
    String? search,
  });

  Future<ResponseModel> uploadImage({required String filePath});
}
