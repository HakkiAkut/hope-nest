import 'dart:io';

import 'package:hope_nest/models/advert.dart';
import 'package:hope_nest/models/app_user.dart';
import 'package:hope_nest/models/comment.dart';
import 'package:hope_nest/models/post.dart';
import 'package:hope_nest/services/database/base/advert_db_base.dart';
import 'package:hope_nest/services/database/base/blog_db_base.dart';
import 'package:hope_nest/services/database/base/comments_db_base.dart';
import 'package:hope_nest/services/database/base/user_db_base.dart';
import 'package:hope_nest/services/database/firebase/database_service.dart';
import 'package:hope_nest/services/storage/base/storage_base.dart';
import 'package:hope_nest/services/storage/firebase/storage_service.dart';
import 'package:hope_nest/util/enum/database_service.dart';
import 'package:hope_nest/util/enum/storage_service_type.dart';
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
        AuthMethods,
        UserMethods,
        AdvertMethods,
        BlogMethods,
        CommentMethods,
        StorageMethods {
  final AuthService _auth = serviceLocator<AuthService>();
  final UserDatabaseService _firestore = serviceLocator<UserDatabaseService>();
  final StorageService _storage = serviceLocator<StorageService>();
  final WebService webService = WebService.FIREBASE;
  final DBService dbService = DBService.FIRESTORE;
  final StorageServiceType sSType = StorageServiceType.FIREBASE;

  @override
  Future<AppUser?> currentUser() async {
    if (webService == WebService.FIREBASE) {
      AppUser? appUser = await _auth.currentUser();
      if (appUser != null) {
        return await _firestore.getUser(id: appUser.uid);
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
  Future<AppUser?> getUser({required String id}) async {
    if (dbService == DBService.FIRESTORE) {
      return await _firestore.getUser(id: id);
    }
    return null;
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

  @override
  Future<List<Comment>>? getC() {}

  @override
  Stream<List<Post>>? getPosts() {
    if (dbService == DBService.FIRESTORE) {
      return _firestore.getPosts();
    }
    return null;
  }

  @override
  Future<List<Comment>?>? getCommentByPID({required String pid}) async {
    if (dbService == DBService.FIRESTORE) {
      return await _firestore.getCommentByPID(pid: pid);
    }
    return null;
  }

  @override
  Stream<List<Advert>>? getAdvertsByUID({required String uid}) {
    if (dbService == DBService.FIRESTORE) {
      return _firestore.getAdvertsByUID(uid: uid);
    }
    return null;
  }

  @override
  Future<String?>? uploadFile(
      {required String uid, required File uploadedFile}) {
    if (sSType == StorageServiceType.FIREBASE) {
      return _storage.uploadFile(uid: uid, uploadedFile: uploadedFile);
    }
    return null;
  }
}
