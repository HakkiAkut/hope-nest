import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hope_nest/models/messages.dart';
import 'package:hope_nest/models/post.dart';
import 'package:hope_nest/repository/repository.dart';
import 'package:hope_nest/services/database/base/blog_db_base.dart';
import 'package:hope_nest/services/database/base/message_db.dart';
import 'package:hope_nest/services/storage/base/storage_base.dart';
import 'package:hope_nest/util/enum/app_state.dart';
import 'package:hope_nest/util/init/service_locator.dart';

class MessageVM with ChangeNotifier implements MessageMethod {
  AppState _state = AppState.IDLE;
  final Repository _repository = serviceLocator<Repository>();
  Map<String,String> _tokens = <String,String>{};

  AppState get state => _state;

  set state(AppState value) {
    _state = value;
    notifyListeners();
  }



  Stream<List<Messages>>? openChatroom({required String cid, required uid}) {
    try {
      return getMessage(cid: cid);
    } finally {
      getToken(id: uid);
    }
  }

  @override
  Stream<List<Messages>>? getMessage({required String cid}) {
      return _repository.getMessage(cid: cid);
  }

  void getToken({required String id}) async {
    _tokens[id] = await _repository.getToken(id: id);
  }

  @override
  Future<bool?> setMessage(
      {required String cid, required Messages message}) async {
    bool? isDone;
    try {
      isDone = await _repository.setMessage(cid: cid, message: message);
      return isDone;
    } finally {
      if (isDone == true) {
        _repository.sendNotification(
            title: message.fromName!, body: message.message!, token: _tokens[message.to]!);
      }
    }
  }
}
