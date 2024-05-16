import '../../models/model_response.dart';
import '../../models/model_user.dart';
import '../service_user.dart';

class UserFirebaseService extends UserService {
  UserFirebaseService._init();
  static final UserFirebaseService instance = UserFirebaseService._init();

  @override
  Future<ResponseModel> getUserById(String userId) {
    // TODO: implement getUserById
    throw UnimplementedError();
  }

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
  Future<ResponseModel> createUser(UserModel user) {
    // TODO: implement createUser
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel> uploadImage({required String filePath}) {
    // TODO: implement uploadImage
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel> updateUser(UserModel user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel> deleteUserById(String userId) {
    // TODO: implement deleteUserById
    throw UnimplementedError();
  }
}
