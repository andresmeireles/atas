import 'dart:convert';

import 'package:atas/src/core/core.dart';
import 'package:atas/src/feature/minute/minute.dart';
import 'package:multiple_result/multiple_result.dart';

class Meet with AppHttpCore {
  Future<Result<List<MeetType>, FailResponse>> get types async {
    final request = getRequest('v1/meets');
    final response = await request;

    return response.when(
      (success) {
        final data = jsonDecode(success) as List<dynamic>;
        final meetTypes = data.map((e) => MeetType.fromMap(e)).toList();
        return Success(meetTypes);
      },
      (error) => Error(error),
    );
  }

  Future<Result<MeetType, FailResponse>> getMeetTypeByName(String meetTypeName) async {
    final request = getRequest('v1/meets/$meetTypeName');
    final response = await request;

    return response.when(
      (success) => Success(MeetType.fromMap(jsonDecode(success))),
      (error) => Error(error),
    );
  }

  Future<Result<List<MeetItem>, FailResponse>> getMeetItems(int meetTypeId) async {
    final request = getRequest('v1/meets/$meetTypeId/items');
    final response = await request;

    return response.when(
      (success) {
        final data = jsonDecode(success);
        final types = List<Map<String, dynamic>>.from(data);
        final typesList = types.map((e) => MeetItem.fromMap(e)).toList();

        return Success(typesList);
      },
      (error) => Error(error),
    );
  }
}
