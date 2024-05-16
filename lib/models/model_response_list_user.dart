import 'model_user.dart';

class UserListResponseModel {
  final List<UserModel> users;

  UserListResponseModel({
    required this.users,
  });

  factory UserListResponseModel.fromJson(dynamic json) => UserListResponseModel(
        users: List.from(json["users"] ?? []).map(UserModel.fromJson).toList(),
      );
}
