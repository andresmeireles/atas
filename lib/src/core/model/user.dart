// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String name;
  final int id;
  final String username;
  final String email;

  User({required this.name, required this.id, required this.username, required this.email});

  factory User.empty() => User(name: '', id: 0, username: '', email: '');

  Map<String, dynamic> toMap() => {'name': name, 'id': id, 'username': username, 'email': email};

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] as String,
      id: map['id'] as int,
      username: map['username'] as String,
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

  User copyWith({String? name, int? id, String? username, String? email}) {
    return User(
      name: name ?? this.name,
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
    );
  }
}
