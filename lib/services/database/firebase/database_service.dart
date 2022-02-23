import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hope_nest/models/advert.dart';
import 'package:hope_nest/models/app_user.dart';
import 'package:hope_nest/models/post.dart';
import 'package:hope_nest/services/database/base/advert_db_base.dart';
import 'package:hope_nest/services/database/base/blog_db_base.dart';
import 'package:hope_nest/services/database/base/user_db_base.dart';

class UserDatabaseService implements UserMethods, AdvertMethods, BlogMethods {
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
}
