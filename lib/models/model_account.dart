class ContactModel {
  final String? firstName;
  final String? lastName;

  ContactModel({
    this.firstName,
    this.lastName,
  });

  factory ContactModel.fromJson(json) {
    final dynamic data = json.data();
    return ContactModel(
      firstName: data["firstName"],
      lastName: data["lastName"],
    );
  }
}
