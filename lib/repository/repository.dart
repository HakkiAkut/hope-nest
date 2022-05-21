import 'dart:io';
import 'package:hope_nest/models/advert.dart';
import 'package:hope_nest/models/app_user.dart';
import 'package:hope_nest/models/comment.dart';
import 'package:hope_nest/models/post.dart';
import 'package:hope_nest/models/report.dart';
import 'package:hope_nest/models/chatroom.dart';
import 'package:hope_nest/models/messages.dart';
import 'package:hope_nest/models/search.dart';
import 'package:hope_nest/services/database/base/advert_db_base.dart';
import 'package:hope_nest/services/database/base/chatRoom_db.dart';
import 'package:hope_nest/services/database/base/message_db.dart';
import 'package:hope_nest/services/database/base/blog_db_base.dart';
import 'package:hope_nest/services/database/base/comments_db_base.dart';
import 'package:hope_nest/services/database/base/report_db_base.dart';
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
        ChatRoomMethod,
        MessageMethod,
        AuthMethods,
        UserMethods,
        AdvertMethods,
        BlogMethods,
        CommentMethods,
        StorageMethods,
        ReportMethods {
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
        print(appUser.uid);
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
      {required String email,
      required String pwd,
      String? name,
      String? surname,
      String? phone,
      String? location}) async {
    if (webService == WebService.FIREBASE) {
      AppUser? appUser = await _auth.signUpWithEmail(email: email, pwd: pwd);
      if (appUser != null) {
        appUser.name = name;
        appUser.surname = surname;
        appUser.phone = phone;
        appUser.location = location;
        appUser.description = "An animal lover";
        appUser.isBanned = false;
        appUser.isAdmin = false;
        await setUser(appUser: appUser);
        return await currentUser();
      }
    }
    return null;
  }

  @override
  Future<AppUser?> signInWithEmail(
      {required String email, required String pwd}) async {
    print("start repo");
    if (webService == WebService.FIREBASE) {
      print("start repo firebase");
      AppUser? appUser = await _auth.signInWithEmail(email: email, pwd: pwd);
      print("repo return");
      if (appUser != null) {
        print("not null");
        print(appUser.uid);
        return await currentUser();
      }
    }
    print("null");
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

  Stream<List<Advert>>? getFilteredAdverts(
      {required SearchAdvert searchAdvert}) {
    if (dbService == DBService.FIRESTORE) {
      return _firestore.getFilteredAdverts(searchAdvert: searchAdvert);
    }
    return null;
  }

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

  @override
  Future<bool?> setAdvert({required Advert advert}) async {
    if (dbService == DBService.FIRESTORE) {
      bool? ret = await _firestore.setAdvert(advert: advert);
      return ret;
    }
    return null;
  }

  @override
  Future<bool?> setReport({required Report report,required bool isSuspended}) async {
    if (dbService == DBService.FIRESTORE) {
      bool? ret = await _firestore.setReport(report: report,isSuspended: isSuspended);
      return ret;
    }
    return null;
  }

  @override
  Stream<List<ChatRoom>>? getChatRoom({required String id}) {
    if (dbService == DBService.FIRESTORE) {
      return _firestore.getChatRoom(id: id);
    }
    return null;
  }

  @override
  Stream<List<Messages>>? getMessage({required String cid}) {
    if (dbService == DBService.FIRESTORE) {
      return _firestore.getMessage(cid: cid);
    }
    return null;
  }

  @override
  Stream<List<Report>>? getReports() {
    if (dbService == DBService.FIRESTORE) {
      return _firestore.getReports();
    }
    return null;
  }

  @override
  Future<Advert?> getAdvertByID({required String id}) async {
    if (dbService == DBService.FIRESTORE) {
      return await _firestore.getAdvertByID(id: id);
    }
    return null;
  }

  @override
  Future<Post?> getPostByID({required String id}) async {
    if (dbService == DBService.FIRESTORE) {
      return await _firestore.getPostByID(id: id);
    }
    return null;
  }

  @override
  Future<bool?> setPost({required Post post}) async {
    if (dbService == DBService.FIRESTORE) {
      return await _firestore.setPost(post: post);
    }
    return null;
  }
}
