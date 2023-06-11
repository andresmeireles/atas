import 'package:atas/env.dart';
import 'package:atas/src/core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:multiple_result/multiple_result.dart';
import 'package:package_info_plus/package_info_plus.dart';

mixin AppHttpCore {
  Future<Map<String, String>> _headers() async {
    final token = await getToken();
    final pkgInfo = await PackageInfo.fromPlatform();
    return {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'App-version': pkgInfo.version,
    };
  }

  Uri _url(String path) {
    final urlPath = '$api/$path';
    return Uri.http(appPath, urlPath);
  }

  @protected
  Future<Result<String, FailResponse>> postRequest(String path, Submittable body) async {
    final url = _url(path);
    final request = http.post(url, body: body.toJson(), headers: await _headers());
    final response = await request;
    if (response.statusCode > 399) {
      return Error(FailResponse.fromJson(response.body));
    }

    return Success(response.body);
  }

  Future<Result<String, FailResponse>> getRequest(String path) async {
    final url = _url(path);
    final request = http.get(url, headers: await _headers());
    final response = await request;
    if (response.statusCode > 399) {
      return Error(FailResponse.fromJson(response.body));
    }

    return Success(response.body);
  }

  @protected
  Future<Result<String, FailResponse>> putRequest(String path, Submittable body) async {
    final url = _url(path);
    final request = http.put(url, body: body.toJson(), headers: await _headers());
    final response = await request;
    if (response.statusCode > 399) {
      return Error(FailResponse.fromJson(response.body));
    }

    return Success(response.body);
  }
}
