import '../../interfaces/interface_user.dart';
import '../../models/model_response.dart';

class UserFirebaseService extends IUser {
  UserFirebaseService._init();
  static final UserFirebaseService instance = UserFirebaseService._init();

  @override
  Future<ResponseModel> getAllUsers({
    required int skip,
    required int take,
    String? search,
  }) {
    // TODO: implement createAccount
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel> uploadImage({required String filePath}) {
    // TODO: implement uploadImage
    throw UnimplementedError();
  }
}
