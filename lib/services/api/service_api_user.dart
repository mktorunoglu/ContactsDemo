import '../../constants/constants_url.dart';
import '../../helpers/helper_dio.dart';
import '../../interfaces/interface_user.dart';
import '../../models/model_response.dart';
import '../../models/model_response_image_upload.dart';
import '../../models/model_response_list_user.dart';

class UserApiService extends IUser {
  UserApiService._init();
  static final UserApiService instance = UserApiService._init();

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
}
