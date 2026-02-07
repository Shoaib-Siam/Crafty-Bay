class UpdateProfileRequestModel {
  final String firstName;
  final String lastName;
  final String phone;
  final String city;

  UpdateProfileRequestModel({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.city,
  });

  Map<String, dynamic> toJson() {
    return {
      "first_name": firstName,
      "last_name": lastName,
      "phone": phone,
      "city": city,
    };
  }
}
