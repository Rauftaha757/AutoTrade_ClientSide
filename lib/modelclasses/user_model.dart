import 'dart:convert';

class UserModel {
  final String name;
  final String email;
  final String password;
  final String id;
  final String token;

  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.id,
    required this.token,
  });

  /// Factory constructor to create a UserModel from a JSON map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      id: json['_id'] ?? '',
      token: json['token'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      '_id': id,
      'token': token,
    };
  }


  String toJsonString() => jsonEncode(toMap());

  static UserModel fromJsonString(String jsonString) {
    return UserModel.fromJson(jsonDecode(jsonString));
  }
}
