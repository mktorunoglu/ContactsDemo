import '../models/model_response.dart';

abstract class IUser {
  Future<ResponseModel> getAllUsers();
}
