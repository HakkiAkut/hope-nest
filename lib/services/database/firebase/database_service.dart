import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hope_nest/models/advert.dart';
import 'package:hope_nest/models/app_user.dart';
import 'package:hope_nest/models/comment.dart';
import 'package:hope_nest/models/post.dart';
import 'package:hope_nest/services/database/base/advert_db_base.dart';
import 'package:hope_nest/services/database/base/blog_db_base.dart';
import 'package:hope_nest/services/database/base/comments_db_base.dart';
import 'package:hope_nest/services/database/base/user_db_base.dart';

class UserDatabaseService
    implements UserMethods, AdvertMethods, BlogMethods, CommentMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<AppUser?> getUser({required String id}) async {
    try {
      DocumentSnapshot user =
          await _firestore.collection("users").doc(id).get();
      Map<String, dynamic> userData = user.data() as Map<String, dynamic>;
      AppUser newUser = AppUser.fromMap(userData!);
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

  @override
  Stream<List<Advert>> getAdverts() {
    Stream<QuerySnapshot> qp = _firestore
        .collection('adverts')
        .orderBy('date', descending: true)
        .limit(10)
        .snapshots();
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
}
