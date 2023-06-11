import 'dart:convert';

import 'package:atas/src/core/core.dart';

class Login implements Submittable {
  final String username;
  final String password;

  Login({required this.username, required this.password});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'username': username, 'password': password};
  }

  factory Login.fromMap(Map<String, dynamic> map) {
    return Login(username: map['username'] as String, password: map['password'] as String);
  }

  @override
  String toJson() => json.encode(toMap());

  factory Login.fromJson(String source) => Login.fromMap(json.decode(source) as Map<String, dynamic>);
}
