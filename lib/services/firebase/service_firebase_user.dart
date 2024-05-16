import '../../interfaces/interface_user.dart';
import '../../models/model_response.dart';

class UserFirebaseService extends IUser {
  UserFirebaseService._init();
  static final UserFirebaseService instance = UserFirebaseService._init();

  @override
  Future<ResponseModel> getAllUsers() {
    // TODO: implement createAccount
    throw UnimplementedError();
  }
}
