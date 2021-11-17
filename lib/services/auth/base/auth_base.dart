import 'package:hope_nest/models/app_user.dart';

/// Base class for Authentication operations
abstract class AuthMethods{
  Future<AppUser?> currentUser();
  Future<AppUser> signInWithPhoneNumber({required String phone});
  Future<bool> signOut();
}