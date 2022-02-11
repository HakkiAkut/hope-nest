import 'package:hope_nest/models/advert.dart';
import 'package:hope_nest/models/app_user.dart';
import 'package:hope_nest/services/database/base/advert_db_base.dart';
import 'package:hope_nest/services/database/base/user_db_base.dart';
import 'package:hope_nest/services/database/firebase/database_service.dart';
import 'package:hope_nest/util/enum/database_service.dart';
import 'package:hope_nest/util/init/service_locator.dart';
import 'package:hope_nest/util/enum/web_service.dart';
import 'package:hope_nest/services/auth/base/auth_base.dart';
import 'package:hope_nest/services/auth/firebase/auth.dart';

/// user repository, manages web services for Authentication methods
/// If WebService is FIREBASE then it will work with firebase methods
/// otherwise if there is another service it will work with other one.
/// Works like DAO manager basically.
class Repository implements AuthMethods, UserMethods, AdvertMethods {
  final AuthService _auth = serviceLocator<AuthService>();
  final UserDatabaseService _firestore = serviceLocator<UserDatabaseService>();
  final WebService webService = WebService.FIREBASE;
  final DBService dbService = DBService.FIRESTORE;

  @override
  Future<AppUser?> currentUser() async {
    if (webService == WebService.FIREBASE) {
      AppUser? appUser = await _auth.currentUser();
      if (appUser != null) {
        // TODO get current user from firestore
        return await appUser;
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
  Future<AppUser?> signUpWithEmail(
      {required String email, required String pwd}) async {
    if (webService == WebService.FIREBASE) {
      AppUser? appUser = await _auth.signUpWithEmail(email: email, pwd: pwd);
      if (appUser != null) {
        await setUser(appUser: appUser);
        return await currentUser();
      }
    }
    return null;
  }

  @override
  Future<AppUser?> signInWithEmail(
      {required String email, required String pwd}) async {
    if (webService == WebService.FIREBASE) {
      AppUser? appUser = await _auth.signInWithEmail(email: email, pwd: pwd);
      if (appUser != null) {
        return await currentUser();
      }
    }
    return null;
  }

  @override
  Future<AppUser?> getUser({required String id}) {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<bool?> setUser({required AppUser appUser}) async {
    if (dbService == DBService.FIRESTORE) {
      return await _firestore.setUser(appUser: appUser);
    }
    return null;
  }

  @override
  Stream<List<Advert>>? getAdverts() {
    if (dbService == DBService.FIRESTORE) {
      return _firestore.getAdverts();
    }
    return null;
  }
}
