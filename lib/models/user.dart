import 'package:meta/meta.dart';

class User {
  String name;
  String email;
  String address;
  String phone;
  String photo;

  User({
    required this.name,
    required this.email,
    required this.address,
    required this.phone,
    required this.photo,
  });

  factory User.fromMap(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        address: json["address"],
        phone: json["phone"],
        photo: json["photo"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "email": email,
        "address": address,
        "phone": phone,
        "photo": photo,
      };
}
