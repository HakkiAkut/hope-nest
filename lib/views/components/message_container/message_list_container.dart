import 'package:flutter/material.dart';
import 'package:hope_nest/models/messages.dart';
import 'package:hope_nest/util/constants/navigation_constants.dart';
import 'package:hope_nest/util/methods/dynamic_size.dart';
import 'package:intl/intl.dart';

class MessageListContainer extends StatelessWidget {
  final Messages message;

  const MessageListContainer({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          margin: EdgeInsets.only(bottom: DynamicSize.height(context, 0.036)),
          height: DynamicSize.height(context, 0.097),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.orangeAccent),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(width: 1, color: Colors.orangeAccent),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),

                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "${message.message}",
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),

            ],
          ),
        ),
        onTap: () {
          //print(chatRoom.id);
          Navigator.pushNamed(context, NavigationConstants.MESSAGE,
              arguments: message);
        });
  }
}