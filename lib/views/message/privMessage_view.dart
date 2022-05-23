import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hope_nest/models/chatroom.dart';
import 'package:hope_nest/models/messages.dart';
import 'package:hope_nest/view_models/message_vm.dart';
import 'package:hope_nest/views/components/message_container/message_list_container.dart';
import 'package:hope_nest/views/components/styles/button_style.dart';
import 'package:provider/provider.dart';

import '../../view_models/app_user_vm.dart';
import '../components/custom_floating_action_button/custom_floating_action_button.dart';

class PrivMessage_View extends StatefulWidget {
  final ChatRoom chatroom;
  const PrivMessage_View({Key? key, required this.chatroom}) : super(key: key);

  @override
  _MessagesViewState createState() => _MessagesViewState();

}

class _MessagesViewState extends State<PrivMessage_View> {
  String msg='';
  final textFieldController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _message_vm = Provider.of<List<Messages>>(context);
    final messagevm = Provider.of<MessageVM>(context);
    final _appUserVM = Provider.of<AppUserVM>(context);
    Messages message;


    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListView.builder(

              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: _message_vm.length,
              itemBuilder: (BuildContext context, int index) {
                return MessageListContainer(message:_message_vm[index]);
              }),
          Container(
          decoration: KmesajContainerDecoration,
          child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Expanded(
          child: TextField(
          controller: textFieldController,
          onChanged: (value){
          changeMessage(value);
          },
          decoration:kMesajTextFieldDecoration,
          ),

          ),
          FlatButton(
          onPressed:()async{
            if(msg!='') {
              message=Messages(from:_appUserVM.appUser!.uid, to: widget.chatroom.users[0]==_appUserVM.appUser!.uid ? widget.chatroom.users[1] : widget.chatroom.users[0],
          message: msg, id: _appUserVM.appUser!.uid + DateTime.now().millisecondsSinceEpoch.toString() );
          await messagevm.setMessage(cid: widget.chatroom.id, message:message);
          print(message.id);
          textFieldController.clear();
          msg='';
            }
          } ,
          child: Text('SEND', style: kGonderButtonTextStyle,),
          )
          ],
          ),
    ),

        ],
      ),

    );
  }
  void changeMessage(String val){
    msg=val;
  }
}
const kGonderButtonTextStyle=TextStyle(
  color:Colors.deepOrangeAccent,
  fontWeight: FontWeight.bold,
  fontSize:18.0,
);
const kMesajTextFieldDecoration=InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
  hintText: 'Enter your message',

  border: InputBorder.none,
);
const KmesajContainerDecoration=BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent,width: 2.0),
  ),
);
