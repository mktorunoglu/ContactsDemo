import '../../constants/constants_url.dart';
import '../../helpers/helper_dio.dart';
import '../../models/model_response.dart';
import '../../models/model_response_image_upload.dart';
import '../../models/model_response_list_user.dart';
import '../../models/model_user.dart';
import '../service_user.dart';

class UserApiService extends UserService {
  UserApiService._init();
  static final UserApiService instance = UserApiService._init();

  @override
  Future<ResponseModel> getUserById(String userId) async {
    final ResponseModel response =
        await DioHelper.instance.get("$urlApiUser/$userId");
    if (response.success == true) {
      response.data = UserModel.fromJson(response.data);
    }
    return response;
  }

  @override
  Future<ResponseModel> getAllUsers({
    required int skip,
    required int take,
    String? search,
  }) async {
    final ResponseModel response = await DioHelper.instance.get(
      urlApiUser,
      queryParameters: {
        "skip": skip,
        "take": take,
        "search": search,
      },
    );
    if (response.success == true) {
      response.data = UserListResponseModel.fromJson(response.data).users;
    }
    return response;
  }

  @override
  Future<ResponseModel> createUser(UserModel user) async {
    final ResponseModel response = await DioHelper.instance.post(
      urlApiUser,
      data: user.toJson(),
    );
    if (response.success == true) {
      response.data = UserModel.fromJson(response.data);
    }
    return response;
  }

  @override
  Future<ResponseModel> uploadImage({required String filePath}) async {
    final ResponseModel response = await DioHelper.instance.post(
      "$urlApiUser/UploadImage",
      data: await DioHelper.instance.getFormDataFromImageFilePath(filePath),
    );
    if (response.success == true) {
      response.data = UploadImageResponseModel.fromJson(response.data).imageUrl;
    }
    return response;
  }

  @override
  Future<ResponseModel> updateUser(UserModel user) async {
    final ResponseModel response = await DioHelper.instance.put(
      "$urlApiUser/${user.id}",
      data: user.toJson(),
    );
    if (response.success == true) {
      response.data = UserModel.fromJson(response.data);
    }
    return response;
  }

  @override
  Future<ResponseModel> deleteUserById(String userId) async =>
      await DioHelper.instance.delete("$urlApiUser/$userId");
}
