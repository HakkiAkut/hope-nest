import 'package:hope_nest/models/app_user.dart';

/// Base class for Authentication operations
abstract class AuthMethods{
  Future<AppUser?> currentUser();
  Future<AppUser?> signInWithEmail({required String email, required String pwd});
  Future<AppUser?> signUpWithEmail({required String email, required String pwd});
  Future<bool?> signOut();
}