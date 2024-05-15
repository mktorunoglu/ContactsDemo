class ContactModel {
  final String? firstName;
  final String? lastName;
  final String? phone;

  ContactModel({
    this.firstName,
    this.lastName,
    this.phone,
  });

  factory ContactModel.fromJson(dynamic json) {
    final dynamic data = json.data();
    return ContactModel(
      firstName: data["firstName"],
      lastName: data["lastName"],
      phone: data["phone"],
    );
  }

  Map<String, dynamic> toJson(ContactModel contact) => {
        "firstName": contact.firstName,
        "lastName": contact.lastName,
        "phone": contact.phone,
      };
}
