import 'dart:convert';

class UserModel {
  final String name;
  final String email;
  final String password;
  final String phone;
  final String location;

  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.location,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? password,
    String? phone,
    String? location,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      location: location ?? this.location,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'location': location,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      phone: map['phone'] ?? '',
      location: map['location'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));
}
