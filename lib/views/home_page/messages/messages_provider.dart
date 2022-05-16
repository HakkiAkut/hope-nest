import 'package:flutter/material.dart';
import 'package:hope_nest/models/chatroom.dart';
import 'package:hope_nest/view_models/chatRoom_vm.dart';
import 'package:hope_nest/views/home_page/blog/blog_view.dart';
import 'package:hope_nest/views/home_page/messages/messages_view.dart';
import 'package:provider/provider.dart';

import '../../../models/app_user.dart';
import '../../../util/enum/user_type.dart';
import '../../../view_models/app_user_vm.dart';

class MessagesProvider extends StatelessWidget {
  const MessagesProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _chatRoomVM = Provider.of<ChatRoomVM>(context);
    final _appUserVM = Provider.of<AppUserVM>(context);
    return StreamProvider<List<ChatRoom>>.value(
    value: _chatRoomVM.getChatRoom(id: _appUserVM.appUser!.uid),
    initialData: const [],
    child: const MessagesView(),
    updateShouldNotify: (prev, now) => true,
    );
  }
}