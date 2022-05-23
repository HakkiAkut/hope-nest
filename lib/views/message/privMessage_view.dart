import 'package:flutter/material.dart';
import 'package:hope_nest/models/messages.dart';
import 'package:hope_nest/view_models/message_vm.dart';
import 'package:hope_nest/views/components/message_container/message_list_container.dart';
import 'package:provider/provider.dart';

class MessagesView extends StatefulWidget {
  const MessagesView({Key? key}) : super(key: key);

  @override
  _MessagesViewState createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView> {
  @override
  Widget build(BuildContext context) {
    final _message_vm = Provider.of<List<Messages>>(context);


    return Scaffold(
      backgroundColor: Colors.transparent,

      body: ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: _message_vm.length,
          itemBuilder: (BuildContext context, int index) {
            return Text(_message_vm[index].id);
          }),
    );
  }
}
