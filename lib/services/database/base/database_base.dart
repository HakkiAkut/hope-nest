import 'package:hope_nest/models/app_user.dart';

abstract class DatabaseMethods {
  Future<AppUser?> getUser({required String id});
}