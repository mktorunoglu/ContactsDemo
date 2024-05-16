import '../models/model_response.dart';
import '../models/model_user.dart';

abstract class UserService {
  Future<ResponseModel> getUserById(String userId);

  Future<ResponseModel> getAllUsers({
    required int skip,
    required int take,
    String? search,
  });

  Future<ResponseModel> createUser(UserModel user);

  Future<ResponseModel> uploadImage({required String filePath});

  Future<ResponseModel> updateUser(UserModel user);

  Future<ResponseModel> deleteUserById(String userId);
}
