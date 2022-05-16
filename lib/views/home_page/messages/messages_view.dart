import 'package:flutter/material.dart';
import 'package:hope_nest/models/chatroom.dart';
import 'package:hope_nest/view_models/chatRoom_vm.dart';
import 'package:hope_nest/views/components/chatRoom_container/chatRoom_list_container.dart';
import 'package:provider/provider.dart';

class MessagesView extends StatefulWidget {
  const MessagesView({Key? key}) : super(key: key);

  @override
  _MessagesViewState createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView> {
  @override
  Widget build(BuildContext context) {
    final _chatRoom_vm = Provider.of<List<ChatRoom>>(context);


    return Scaffold(
      backgroundColor: Colors.transparent,

      body: ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: _chatRoom_vm.length,
          itemBuilder: (BuildContext context, int index) {
            return ChatRoomListContainer(chatRoom: _chatRoom_vm[index]);
          }),
    );
  }
}
