import 'package:firebase_auth/firebase_auth.dart';
import 'package:hope_nest/models/app_user.dart';
import 'package:hope_nest/services/auth/base/auth_base.dart';

class AuthService implements AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Firebase current user
  @override
  Future<AppUser?> currentUser() async {
    User? user = _auth.currentUser;

    return user != null ? convertUserToAppUser(user) : null;
  }

  /// Firebase sign out
  @override
  Future<bool?> signOut() async {
    await _auth.signOut().onError((error, stackTrace) => false);
    return true;
  }

  /// converts Firebase user to Application User
  AppUser convertUserToAppUser(User user) {
    return AppUser(uid: user.uid, email: user.phoneNumber);
  }

  @override
  Future<AppUser?> signInWithPhoneNumber({required String phone}) async{
    return await AppUser(uid: "123");
  }
}
