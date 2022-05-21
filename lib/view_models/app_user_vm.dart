import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:hope_nest/models/app_user.dart';
import 'package:hope_nest/models/comment.dart';
import 'package:hope_nest/repository/repository.dart';
import 'package:hope_nest/services/auth/base/auth_base.dart';
import 'package:hope_nest/services/database/base/comments_db_base.dart';
import 'package:hope_nest/services/database/base/user_db_base.dart';
import 'package:hope_nest/services/storage/base/storage_base.dart';
import 'package:hope_nest/util/enum/app_state.dart';
import 'package:hope_nest/util/enum/login_state.dart';
import 'package:hope_nest/util/init/service_locator.dart';

class AppUserVM
    with ChangeNotifier
    implements AuthMethods, UserMethods, CommentMethods, StorageMethods {
  AppState _state = AppState.IDLE;
  LoginState _loginState = LoginState.SIGNIN;

  final Repository _repository = serviceLocator<Repository>();
  AppUser? _appUser;
  AppUser? _advertOwner;
  AppUser? _postOwner;
  List<Comment>? _comments;

  AppUser? get appUser => _appUser;

  AppUser? get advertOwner => _advertOwner;

  AppUser? get postOwner => _postOwner;

  List<Comment>? get comments => _comments;

  AppState get state => _state;

  LoginState get loginState => _loginState;

  AppUserVM() {
    currentUser();
  }

  set state(AppState value) {
    _state = value;
    notifyListeners();
  }

  set loginState(LoginState value) {
    _loginState = value;
    notifyListeners();
  }

  @override
  Future<AppUser?> currentUser() async {
    try {
      print("current");
      state = AppState.BUSY;
      _appUser = await _repository.currentUser();
      if (_appUser != null) {
        if(_appUser?.isBanned == true){
          signOut();
          // TODO: add ban message
        }
        return _appUser;
      } else {
        return null;
      }
    } finally {
      state = AppState.IDLE;
    }
  }

  @override
  Future<AppUser?> signInWithEmail(
      {required String email, required String pwd}) async {
    print("sign in vm");
    try {
      print("start");
      print(email + pwd);
      state = AppState.BUSY;
      _appUser = await _repository.signInWithEmail(email: email, pwd: pwd);
      print(_appUser!.uid);
      return _appUser;
    } finally {
      print(_appUser!.uid);
      state = AppState.IDLE;
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
    try {
      state = AppState.BUSY;
      _appUser = await _repository.signUpWithEmail(
          email: email,
          pwd: pwd,
          name: name,
          surname: surname,
          phone: phone,
          location: location);
      return _appUser;
    } finally {
      state = AppState.IDLE;
    }
  }

  @override
  Future<bool?> signOut() async {
    try {
      state = AppState.BUSY;
      _appUser = null;
      return await _repository.signOut();
    } finally {
      state = AppState.IDLE;
    }
  }

  @override
  Future<AppUser?> getUser({required String id}) async {
    try {
      state = AppState.BUSY;
      return await _repository.getUser(id: id);
    } finally {
      state = AppState.IDLE;
    }
  }
  @override
  Future<AppUser?> getUserByID({required String id}) async {
      return await _repository.getUser(id: id);
  }

  void getAdvertOwner({required String id}) async {
    if (_advertOwner == null || _advertOwner!.uid != id) {
      _advertOwner = await getUser(id: id);
    }
  }

  void getPostOwner({required String id}) async {
    if (_postOwner == null || _postOwner!.uid != id) {
      _postOwner = await getUser(id: id);
    }
  }

  void getCommentAndOwner({required String pid, required String uid}) async {
    if (_comments == null || _comments!.first.pid != pid) {
      try {
        getPostOwner(id: uid);
        _comments = await getCommentByPID(pid: pid);
        print(_comments!.length);
        _comments ??= <Comment>[Comment(id: "", uid: uid, pid: pid)];
      } finally {
        state = AppState.IDLE;
      }
    }
  }

  @override
  Future<bool?> setUser({required AppUser appUser}) async {
    return await _repository.setUser(appUser: appUser);
  }

  @override
  Future<List<Comment>?>? getCommentByPID({required String pid}) async {
    try {
      state = AppState.BUSY;
      return await _repository.getCommentByPID(pid: pid);
    } finally {
      state = AppState.IDLE;
    }
  }

  @override
  Future<String?>? uploadFile(
      {required String uid, required File uploadedFile}) {
    return _repository.uploadFile(uid: uid, uploadedFile: uploadedFile);
  }
}
