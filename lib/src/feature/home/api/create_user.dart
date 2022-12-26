import 'package:atas/src/core/core.dart';

class CreateUser {
  final user = User();

  Future<String> add(String userName) async => await user.addUser(userName);
}
