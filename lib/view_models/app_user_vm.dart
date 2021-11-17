import 'package:flutter/cupertino.dart';
import 'package:hope_nest/models/app_user.dart';
import 'package:hope_nest/repository/repository.dart';
import 'package:hope_nest/services/auth/base/auth_base.dart';
import 'package:hope_nest/util/enum/app_state.dart';
import 'package:hope_nest/util/init/service_locator.dart';

class AppUserVM with ChangeNotifier implements AuthMethods {
  AppState _state = AppState.IDLE;

  final Repository _repository = serviceLocator<Repository>();
  AppUser? _appUser;

  AppUser? get appUser => _appUser;

  AppState get state => _state;

  AppUserVM() {
    currentUser();
  }

  set state(AppState value) {
    _state = value;
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
  Future<AppUser?> signInWithPhoneNumber({required String phone}) async {
    try {
      state = AppState.BUSY;
      _appUser = await _repository.signInWithPhoneNumber(phone: phone);
      return _appUser;
    } finally {
      state = AppState.IDLE;
    }
  }
}