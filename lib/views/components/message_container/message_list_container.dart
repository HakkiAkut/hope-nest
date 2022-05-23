import 'package:flutter/material.dart';
import 'package:hope_nest/models/messages.dart';
import 'package:hope_nest/util/constants/navigation_constants.dart';
import 'package:hope_nest/util/methods/dynamic_size.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../view_models/app_user_vm.dart';

class MessageListContainer extends StatelessWidget {
  final Messages message;
  const MessageListContainer({Key? key, required this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _appUserVM = Provider.of<AppUserVM>(context);
    bool isCurrentUser= (_appUserVM.appUser!.uid==message.from);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
         // Text('${message.from} ' , style:  TextStyle(color: isCurrentUser ? Colors.white: Colors.deepOrangeAccent , fontSize: 10.0),),
          SizedBox(height:5),
          Material(
              borderRadius: isCurrentUser ? BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ) : BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              elevation: 15.0,
              color: isCurrentUser ?Color(0xFF574b90): Colors.deepOrange ,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal:20, vertical :10),
                  child:Text(message.message.toString(), style: TextStyle(color:Colors.white) )

              )

          ),
        ],


      ),
    );
  }
}