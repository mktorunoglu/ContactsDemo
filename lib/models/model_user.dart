class UserModel {
  final String? id;
  final String? createdAt;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? profileImageUrl;

  UserModel({
    this.id,
    this.createdAt,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.profileImageUrl,
  });

  factory UserModel.fromJson(dynamic json) => UserModel(
        id: json["id"],
        createdAt: json["createdAt"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        phoneNumber: json["phoneNumber"],
        profileImageUrl: json["profileImageUrl"],
      );

  Map<String, dynamic> toJson(UserModel contact) => {
        "id": contact.id,
        "createdAt": contact.createdAt,
        "firstName": contact.firstName,
        "lastName": contact.lastName,
        "phoneNumber": contact.phoneNumber,
        "profileImageUrl": contact.profileImageUrl,
      };
}
