import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hope_nest/models/advert.dart';
import 'package:hope_nest/models/app_user.dart';
import 'package:hope_nest/models/comment.dart';
import 'package:hope_nest/models/post.dart';
import 'package:hope_nest/models/chatroom.dart';
import 'package:hope_nest/models/messages.dart';
import 'package:hope_nest/models/report.dart';
import 'package:hope_nest/models/search.dart';
import 'package:hope_nest/services/database/base/advert_db_base.dart';
import 'package:hope_nest/services/database/base/blog_db_base.dart';
import 'package:hope_nest/services/database/base/comments_db_base.dart';
import 'package:hope_nest/services/database/base/report_db_base.dart';
import 'package:hope_nest/services/database/base/chatRoom_db.dart';
import 'package:hope_nest/services/database/base/message_db.dart';
import 'package:hope_nest/services/database/base/user_db_base.dart';
import 'package:hope_nest/services/notification/firebase/notification_service.dart';
import 'package:hope_nest/util/enum/report_type.dart';
import 'package:hope_nest/util/init/service_locator.dart';
import 'package:hope_nest/views/components/toast_message/toast_message.dart';

class UserDatabaseService
    implements
        MessageMethod,
        ChatRoomMethod,
        UserMethods,
        AdvertMethods,
        BlogMethods,
        CommentMethods,
        ReportMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth auth = FirebaseAuth.instance;

  String? getCurrentUserId() {
    final User? user = auth.currentUser;
    final userid = user?.uid;
    return userid;
  }

  @override
  Future<AppUser?> getUser({required String id}) async {
    try {
      DocumentSnapshot user =
          await _firestore.collection("users").doc(id).get();
      Map<String, dynamic> userData = user.data() as Map<String, dynamic>;
      AppUser newUser = AppUser.fromMap(userData);
      return newUser;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  @override
  Future<bool> setUser({required AppUser appUser}) async {
    try {
      await _firestore
          .collection("users")
          .doc(appUser.uid)
          .set(appUser.toMap());
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> setToken({required String token}) async {
    try {
      await _firestore
          .collection("tokens")
          .doc(auth.currentUser!.uid)
          .set({"token": token});
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  @override
  Stream<List<Advert>> getAdverts() {
    Stream<QuerySnapshot> qp = _firestore
        .collection('adverts')
        .where("isBanned", isEqualTo: false)
        .orderBy('date', descending: true)
        .limit(10)
        .snapshots();
    return qp.map((docs) => docs.docs
        .map((doc) => Advert.fromMap(doc.data() as Map<String, dynamic>))
        .toList());
  }

  Stream<List<Advert>> getFilteredAdverts(
      {required SearchAdvert searchAdvert}) {
    Query query =
        _firestore.collection('adverts').where("isBanned", isEqualTo: false);
    if (searchAdvert.location != '' && searchAdvert.location != null) {
      query = query.where('location', isEqualTo: searchAdvert.location);
    }
    if (searchAdvert.kind != '' && searchAdvert.kind != null) {
      query = query.where('kind', isEqualTo: searchAdvert.kind);
    }
    Stream<QuerySnapshot> qp =
        query.orderBy('date', descending: true).limit(10).snapshots();
    return qp.map((docs) => docs.docs
        .map((doc) => Advert.fromMap(doc.data() as Map<String, dynamic>))
        .toList());
  }

  @override
  Stream<List<Post>> getPosts() {
    Stream<QuerySnapshot> qp = _firestore
        .collection('posts')
        .orderBy('date', descending: true)
        .limit(10)
        .snapshots();
    return qp.map((docs) => docs.docs
        .map((doc) => Post.fromMap(doc.data() as Map<String, dynamic>))
        .toList());
  }

  Stream<List<Post>> getFilteredPosts({required SearchPost searchPost}) {
    print(searchPost.title);
    Query query =
        _firestore.collection('posts').where("isBanned", isEqualTo: false);
    if (searchPost.title != '' && searchPost.title != null) {
      query = query
          .where("title", isGreaterThanOrEqualTo: searchPost.title)
          .where("title", isLessThan: searchPost.title! + 'z')
          .orderBy("title", descending: true);
    }
    Stream<QuerySnapshot> qp =
        query.orderBy('date', descending: true).limit(10).snapshots();
    return qp.map((docs) => docs.docs
        .map((doc) => Post.fromMap(doc.data() as Map<String, dynamic>))
        .toList());
  }

  @override
  Future<List<Comment>?>? getCommentByPID({required String pid}) async {
    QuerySnapshot qp = await _firestore
        .collection('comments')
        .where('postId', isEqualTo: pid)
        .orderBy('date', descending: true)
        .get();

    return qp.docs
        .map((doc) => Comment.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  @override
  Stream<List<Advert>>? getAdvertsByUID({required String uid}) {
    Stream<QuerySnapshot> qp = _firestore
        .collection('adverts')
        .where("userId", isEqualTo: uid)
        .orderBy('date', descending: true)
        .limit(10)
        .snapshots();
    return qp.map((docs) => docs.docs
        .map((doc) => Advert.fromMap(doc.data() as Map<String, dynamic>))
        .toList());
  }

  @override
  Future<bool?> setAdvert({required Advert advert}) async {
    try {
      await _firestore.collection("adverts").doc(advert.id).set(advert.toMap());
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  @override
  Future<bool?> setReport(
      {required Report report, required bool isSuspended}) async {
    try {
      await _firestore
          .collection("report")
          .doc(report.id)
          .set(report.toMap())
          .then((value) async {
        if (isSuspended) {
          getDoneMessage(text: "successful");
          if (report.reportType == ReportType.USER) {
            report.reportUser!.isBanned = true;
            await setUser(appUser: report.reportUser!);
          } else if (report.reportType == ReportType.ADVERT) {
            report.reportAdvert!.isBanned = true;
            await setAdvert(advert: report.reportAdvert!);
          } else {
            report.reportPost!.isBanned = true;
            await setPost(post: report.reportPost!);
          }
        }
      });
      return true;
    } catch (e) {
      getErrorMessage(text: "an error occurred: ${e.toString()}");
      print(e.toString());
      return false;
    }
  }

  @override
  Stream<List<ChatRoom>>? getChatRoom({required String id}) {
    Stream<QuerySnapshot> qp = _firestore
        .collection('chatRoom')
        .where("users", arrayContains: id) //users firebase deki array
        .orderBy('time', descending: true)
        .snapshots();
    return qp.map((docs) => docs.docs
        .map((doc) => ChatRoom.fromMap(doc.data() as Map<String, dynamic>))
        .toList());
  }

  @override
  Stream<List<Messages>>? getMessage({required String cid}) {
    Stream<QuerySnapshot> q = _firestore
        .collection('chatRoom')
        .doc(cid)
        .collection('messages')
        .orderBy('time')
        .snapshots();
    return q.map((docs) => docs.docs
        .map((doc) => Messages.fromMap(doc.data() as Map<String, dynamic>))
        .toList());
  }

  @override
  Stream<List<Report>>? getReports() {
    Stream<QuerySnapshot> qp = _firestore
        .collection('report')
        .orderBy('date', descending: true)
        .snapshots();
    return qp.map((docs) => docs.docs
        .map((doc) => Report.fromMap(doc.data() as Map<String, dynamic>))
        .toList());
  }

  Stream<List<Report>> getFilteredReports(
      {required SearchReport searchReport}) {
    Query query = _firestore.collection('report');
    if (searchReport.isDone != null) {
      query = query.where('isDone', isEqualTo: searchReport.isDone);
    }
    Stream<QuerySnapshot> qp =
        query.orderBy('date', descending: true).limit(10).snapshots();
    return qp.map((docs) => docs.docs
        .map((doc) => Report.fromMap(doc.data() as Map<String, dynamic>))
        .toList());
  }

  @override
  Future<Advert?> getAdvertByID({required String id}) async {
    try {
      DocumentSnapshot advert =
          await _firestore.collection("adverts").doc(id).get();
      Map<String, dynamic> advertData = advert.data() as Map<String, dynamic>;
      Advert newAdvert = Advert.fromMap(advertData);
      return newAdvert;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  @override
  Future<Post?> getPostByID({required String id}) async {
    try {
      DocumentSnapshot post =
          await _firestore.collection("posts").doc(id).get();
      Map<String, dynamic> postData = post.data() as Map<String, dynamic>;
      Post newPost = Post.fromMap(postData);
      return newPost;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  @override
  Future<bool?> setPost({required Post post}) async {
    try {
      await _firestore.collection("posts").doc(post.id).set(post.toMap());
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  @override
  Future<bool?> setMessage(
      {required String cid, required Messages message}) async {
    try {
      await _firestore
          .collection("chatRoom")
          .doc(cid)
          .collection('messages')
          .doc(message.id)
          .set(message.toMap());
      //print("eklendii");
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<String> getToken({required String id}) async {
    DocumentSnapshot tokenData =
        await _firestore.collection("tokens").doc(id).get();
    Map<String, dynamic> userData = tokenData.data() as Map<String, dynamic>;
    return userData["token"];
  }
}
