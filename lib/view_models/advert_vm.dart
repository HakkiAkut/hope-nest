import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hope_nest/models/advert.dart';
import 'package:hope_nest/models/search.dart';
import 'package:hope_nest/repository/repository.dart';
import 'package:hope_nest/services/database/base/advert_db_base.dart';
import 'package:hope_nest/services/storage/base/storage_base.dart';
import 'package:hope_nest/util/enum/app_state.dart';
import 'package:hope_nest/util/init/service_locator.dart';

class AdvertVM with ChangeNotifier implements AdvertMethods, StorageMethods {
  AppState _state = AppState.IDLE;
  final Repository _repository = serviceLocator<Repository>();
  int limit = 10;
  SearchAdvert _searchAdvert = SearchAdvert();

  AppState get state => _state;

  SearchAdvert get searchAdvert => _searchAdvert;

  set state(AppState value) {
    _state = value;
    notifyListeners();
  }

  set searchAdvert(SearchAdvert searchAdvert) {
    _searchAdvert = searchAdvert;
    print(searchAdvert.location);
    notifyListeners();
  }

  bool isSearchAdvertNull() {
    return (_searchAdvert.location == null || _searchAdvert.location == '')
        ? true
        : false;
  }

  @override
  Stream<List<Advert>>? getAdverts() {
    print("getadverts");
    return isSearchAdvertNull()
        ? _repository.getAdverts()
        : _repository.getFilteredAdverts(searchAdvert: _searchAdvert);
  }

  @override
  Stream<List<Advert>>? getAdvertsByUID({required String uid}) {
    return _repository.getAdvertsByUID(uid: uid);
  }

  @override
  Future<String?>? uploadFile(
      {required String uid, required File uploadedFile}) {
    return _repository.uploadFile(uid: uid, uploadedFile: uploadedFile);
  }

  @override
  Future<bool?> setAdvert({required Advert advert}) async {
    if (advert.url != "") {
      advert.url =
          (await uploadFile(uid: advert.uid, uploadedFile: File(advert.url)))!;
    }
    return _repository.setAdvert(advert: advert);
  }
}
