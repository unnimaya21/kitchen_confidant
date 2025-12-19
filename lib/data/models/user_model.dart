import 'package:kitchen_confidant/domain/entities/user_entity.dart';

class User extends UserEntity {
  User({
    String? id,
    required String username,
    required String email,
    required String password,
  }) : super(id: id!, username: username, email: email, password: password);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      username: json['username'],
      email: json['email'],
      password: json['password'] ?? '',
    );
  }
  toJson() {
    return {
      '_id': id,
      'username': username,
      'email': email,
      'password': password,
      'confirmPassword': password,
    };
  }
}
