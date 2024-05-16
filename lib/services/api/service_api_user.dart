import '../../constants/constants_url.dart';
import '../../helpers/helper_dio.dart';
import '../../interfaces/interface_user.dart';
import '../../models/model_response.dart';
import '../../models/model_response_list_user.dart';

class UserApiService extends IUser {
  UserApiService._init();
  static final UserApiService instance = UserApiService._init();

  @override
  Future<ResponseModel> getAllUsers() async {
    final ResponseModel response = await DioHelper.instance.get(urlApiUser);
    if (response.success == true) {
      response.data = UserListResponseModel.fromJson(response.data).users;
    }
    return response;
  }
}
