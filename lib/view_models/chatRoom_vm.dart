import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hope_nest/models/chatroom.dart';
import 'package:hope_nest/models/post.dart';
import 'package:hope_nest/repository/repository.dart';
import 'package:hope_nest/services/database/base/blog_db_base.dart';
import 'package:hope_nest/services/database/base/chatRoom_db.dart';
import 'package:hope_nest/services/storage/base/storage_base.dart';
import 'package:hope_nest/util/enum/app_state.dart';
import 'package:hope_nest/util/init/service_locator.dart';

class ChatRoomVM with ChangeNotifier implements ChatRoomMethod {
  AppState _state = AppState.IDLE;
  final Repository _repository = serviceLocator<Repository>();

  AppState get state => _state;

  set state(AppState value) {
    _state = value;
    notifyListeners();
  }

  @override
  Stream<List<ChatRoom>>? getChatRoom({required String id}) {
    return _repository.getChatRoom(id : id);
  }
}
