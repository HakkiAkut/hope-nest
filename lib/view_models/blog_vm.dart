import 'package:flutter/material.dart';
import 'package:hope_nest/models/post.dart';
import 'package:hope_nest/repository/repository.dart';
import 'package:hope_nest/services/database/base/blog_db_base.dart';
import 'package:hope_nest/util/enum/app_state.dart';
import 'package:hope_nest/util/init/service_locator.dart';

class BlogVM with ChangeNotifier implements BlogMethods {
  AppState _state = AppState.IDLE;
  final Repository _repository = serviceLocator<Repository>();
  int limit = 10;

  AppState get state => _state;

  set state(AppState value) {
    _state = value;
    notifyListeners();
  }

  @override
  Stream<List<Post>>? getPosts() {
    return _repository.getPosts();
  }
}