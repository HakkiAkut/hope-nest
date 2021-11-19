import 'package:hope_nest/models/app_user.dart';

abstract class UserMethods {
  Future<AppUser?> getUser({required String id});
  Future<bool?> setUser({required AppUser appUser});
}