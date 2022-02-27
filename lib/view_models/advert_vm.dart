import 'package:flutter/material.dart';
import 'package:hope_nest/models/advert.dart';
import 'package:hope_nest/repository/repository.dart';
import 'package:hope_nest/services/database/base/advert_db_base.dart';
import 'package:hope_nest/util/enum/app_state.dart';
import 'package:hope_nest/util/init/service_locator.dart';

class AdvertVM with ChangeNotifier implements AdvertMethods {
  AppState _state = AppState.IDLE;
  final Repository _repository = serviceLocator<Repository>();
  int limit = 10;

  AppState get state => _state;

  set state(AppState value) {
    _state = value;
    notifyListeners();
  }

  @override
  Stream<List<Advert>>? getAdverts() {
    return _repository.getAdverts();
  }

  @override
  Stream<List<Advert>>? getAdvertsByUID({required String uid}) {
    return _repository.getAdvertsByUID(uid: uid);
  }
}
