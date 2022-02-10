import 'package:flutter/cupertino.dart';
import 'package:hope_nest/models/app_user.dart';
import 'package:hope_nest/repository/repository.dart';
import 'package:hope_nest/services/auth/base/auth_base.dart';
import 'package:hope_nest/services/database/base/user_db_base.dart';
import 'package:hope_nest/util/enum/app_state.dart';
import 'package:hope_nest/util/enum/login_state.dart';
import 'package:hope_nest/util/enum/tabs.dart';
import 'package:hope_nest/util/init/service_locator.dart';

class AppUserVM with ChangeNotifier implements AuthMethods, UserMethods {
  AppState _state = AppState.IDLE;
  LoginState _loginState = LoginState.SIGNIN;
  Tabs _currentTab = Tabs.home;

  final Repository _repository = serviceLocator<Repository>();
  AppUser? _appUser;

  AppUser? get appUser => _appUser;
  AppState get state => _state;
  Tabs get currentTab => _currentTab;
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
  set currentTab(Tabs value) {
    _currentTab = value;
    notifyListeners();
  }

  @override
  Future<AppUser?> currentUser() async {
    try {
      state = AppState.BUSY;
      _appUser = await _repository.currentUser();
      if (_appUser != null) {
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
    try {
      state = AppState.BUSY;
      _appUser = await _repository.signInWithEmail(email: email, pwd: pwd);
      return _appUser;
    } finally {
      state = AppState.IDLE;
    }
  }

  @override
  Future<AppUser?> signUpWithEmail({
    required String email,
    required String pwd,
  }) async {
    try {
      state = AppState.BUSY;
      _appUser = await _repository.signUpWithEmail(email: email, pwd: pwd);
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
  Future<AppUser?> getUser({required String id}) {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<bool?> setUser({required AppUser appUser}) async {
    return await _repository.setUser(appUser: appUser);
  }
}
