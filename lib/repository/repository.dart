import 'package:hope_nest/models/app_user.dart';
import 'package:hope_nest/util/init/service_locator.dart';
import 'package:hope_nest/util/enum/web_service.dart';
import 'package:hope_nest/services/auth/base/auth_base.dart';
import 'package:hope_nest/services/auth/firebase/auth.dart';


/// user repository, manages web services for Authentication methods
/// If WebService is FIREBASE then it will work with firebase methods
/// otherwise if there is another service it will work with other one.
/// Works like DAO manager basically.
class Repository
    implements
        AuthMethods{
  final AuthService _auth = serviceLocator<AuthService>();
  final WebService webService = WebService.FIREBASE;

  @override
  Future<AppUser?> currentUser() async {
    if (webService == WebService.FIREBASE) {
      AppUser? appUser = await _auth.currentUser();
      if (appUser != null) {
        return await AppUser(uid: "uid");
      } else {
        return null;
      }
    }
    return null;
  }

  @override
  Future<bool?> signOut() async {
    if (webService == WebService.FIREBASE) {
      return await _auth.signOut();
    } else {
      return null;
    }
  }

  @override
  Future<AppUser?> signInWithPhoneNumber({required String phone}) async {
    if (webService == WebService.FIREBASE) {
      AppUser? appUser = await _auth.signInWithPhoneNumber(phone: phone);
      if (appUser != null) {
        return await currentUser();
      }
    }
    return null;
  }
}