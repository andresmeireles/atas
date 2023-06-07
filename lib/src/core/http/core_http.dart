import 'dart:convert';

import 'package:atas/env.dart';
import 'package:atas/src/core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:multiple_result/multiple_result.dart';
import 'package:package_info_plus/package_info_plus.dart';

abstract class CoreHttp {
  const CoreHttp();

  Future<Map<String, String>> _headers() async {
    final token = await getToken();
    final pkgInfo = await PackageInfo.fromPlatform();
    return {
      'Authorization': 'Bearer $token',
      'App-version': pkgInfo.version,
      'Accept': 'application/json',
      'Content-type': 'application/json',
    };
  }

  @protected
  Future<Result<String, FailResponse>> postRequest<T>(String path, Object body) async {
    final urlPath = '$api/$path';
    final url = Uri.http(appPath, urlPath);
    final jsonBody = jsonEncode(body);
    final request = http.post(url, body: jsonBody, headers: await _headers());
    final response = await request;
    if (response.statusCode > 399) {
      return Error(FailResponse.fromJson(response.body));
    }
    return Success(response.body);
  }

  // Future<T> getRequest<T>() async {}

  // Future<T> put<T>() async {}
}
