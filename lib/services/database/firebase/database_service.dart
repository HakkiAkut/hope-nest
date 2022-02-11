import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hope_nest/models/advert.dart';
import 'package:hope_nest/models/app_user.dart';
import 'package:hope_nest/services/database/base/advert_db_base.dart';
import 'package:hope_nest/services/database/base/user_db_base.dart';

class UserDatabaseService implements UserMethods, AdvertMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<AppUser?> getUser({required String id}) {
    // TODO: implement getUser
    throw UnimplementedError();
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
}
