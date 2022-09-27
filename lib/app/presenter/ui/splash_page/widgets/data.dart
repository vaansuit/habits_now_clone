import 'dart:convert';

DataModel dataModelFromJson(String str) => dataModelFromJson(json.decode(str));

class DataModel {
  DataModel({
    required this.email,
    required this.name,
    required this.image,
    required this.password,
  });
  String email;
  String name;
  String image;
  String password;

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        email: json['email'],
        name: json['name'],
        image: json['image'],
        password: json['password'],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "image": image,
        "password": password,
      };
}
