import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hope_nest/models/app_user.dart';
import 'package:hope_nest/services/database/base/user_db_base.dart';

class UserDatabaseService implements UserMethods {
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
}
