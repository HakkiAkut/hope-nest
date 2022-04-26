import 'package:firebase_auth/firebase_auth.dart';
import 'package:hope_nest/models/app_user.dart';
import 'package:hope_nest/services/auth/base/auth_base.dart';

class AuthService implements AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Firebase current user
  @override
  Future<AppUser?> currentUser() async {
    User? user = _auth.currentUser;
    print("user bastır");
    print(user);
    print("user bastır 1");

    return user != null ? convertUserToAppUser(user) : null;
  }

  /// Firebase sign out
  @override
  Future<bool?> signOut() async {
    await _auth.signOut().onError((error, stackTrace) => false);
    return true;
  }

  /// converts Firebase user to Application User
  AppUser? convertUserToAppUser(User? user) {
    print("useer");
    print(user);
    return user != null
        ? AppUser(uid: user.uid, email: user.email)
        : null;
  }


  @override
  Future<AppUser?> signUpWithEmail({required String email, required String pwd}) async {
    UserCredential credential =
    await _auth.createUserWithEmailAndPassword(email: email, password: pwd);
    print("auth çalıştı");
    return convertUserToAppUser(credential.user);
  }

  /// Firebase authentication with email and password
  @override
  Future<AppUser?> signInWithEmail({required String email, required String pwd}) async {
    print("auth çalıştı");
    try{
      UserCredential credential =
      await _auth.signInWithEmailAndPassword(email: email, password: pwd);
      print("auth bitti");
      return convertUserToAppUser(credential.user);
    }catch(e){
      print("hata burada fire");
    }
  }

}
