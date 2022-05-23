import 'package:flutter/material.dart';
import 'package:hope_nest/models/chatroom.dart';
import 'package:hope_nest/models/messages.dart';
import 'package:hope_nest/view_models/message_vm.dart';
import 'package:hope_nest/views/message/privMessage_view.dart';
import 'package:provider/provider.dart';

import '../../../models/app_user.dart';
import '../../../util/enum/user_type.dart';
import '../../../view_models/app_user_vm.dart';

class privMessage_provider extends StatelessWidget {
  final ChatRoom chatroom;
  const privMessage_provider({Key? key, required this.chatroom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _messageVM = Provider.of<MessageVM>(context);
    final _appUserVM = Provider.of<AppUserVM>(context);

    return StreamProvider<List<Messages>>.value(
      value: _messageVM.getMessage(cid:chatroom.id),
      initialData: const [],
      child:PrivMessage_View(chatroom: chatroom),
      updateShouldNotify: (prev, now) => true,
    );
  }
}