// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FailResponse {
  final String message;

  const FailResponse._(this.message);

  factory FailResponse.fromMap(Map<String, dynamic> map) => FailResponse._(map['message'] as String);

  factory FailResponse.fromJson(String source) => FailResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
