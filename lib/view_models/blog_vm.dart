import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hope_nest/models/post.dart';
import 'package:hope_nest/repository/repository.dart';
import 'package:hope_nest/services/database/base/blog_db_base.dart';
import 'package:hope_nest/services/storage/base/storage_base.dart';
import 'package:hope_nest/util/enum/app_state.dart';
import 'package:hope_nest/util/init/service_locator.dart';

class BlogVM with ChangeNotifier implements BlogMethods, StorageMethods {
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

  @override
  Future<String?>? uploadFile(
      {required String uid, required File uploadedFile}) {
    return _repository.uploadFile(uid: uid, uploadedFile: uploadedFile);
  }

  @override
  Future<Post?> getPostByID({required String id}) async {
    try {
      state = AppState.BUSY;
      return await _repository.getPostByID(id: id);
    } finally {
      state = AppState.IDLE;
    }
  }

  @override
  Future<bool?> setPost({required Post post}) async {
    try {
      state = AppState.BUSY;
      if (post.url != "") {
        post.url =
        (await uploadFile(uid: post.uid, uploadedFile: File(post.url!)))!;
      }
      return await _repository.setPost(post: post);
    } finally {
      state = AppState.IDLE;
    }
  }
}
