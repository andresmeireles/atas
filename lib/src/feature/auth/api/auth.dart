// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:multiple_result/multiple_result.dart';

import 'package:atas/src/core/core.dart';

class LoginResponse {
  final String token;

  LoginResponse._({required this.token});

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse._(
      token: map['token'] as String,
    );
  }

  factory LoginResponse.fromJson(String source) => LoginResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}

final class Auth extends CoreHttp {
  Future<Result<LoginResponse, FailResponse>> login(String username, String password) async {
    final request = await postRequest<LoginResponse>('v1/login', {'username': username, 'password': password});
    return request.when(
      (success) => Success(LoginResponse.fromJson(success)),
      (error) => Error(error),
    );
  }
}
