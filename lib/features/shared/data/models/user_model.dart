class UserModel {
  String? email;
  String? firstName;
  String? lastName;
  String? phone;
  String? city;
  String? id;

  UserModel({
    this.email,
    this.firstName,
    this.lastName,
    this.phone,
    this.city,
    this.id,
  });

  // FIX: Change the keys here to match your Postman screenshot (snake_case)
  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'city': city,
    };
  }

  String get fullName => '${firstName ?? ''} ${lastName ?? ''}';
}