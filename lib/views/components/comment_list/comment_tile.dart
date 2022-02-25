import 'package:flutter/material.dart';
import 'package:hope_nest/models/comment.dart';
import 'package:hope_nest/util/methods/dynamic_size.dart';

class CommentTile extends StatelessWidget {
  final Comment comment;

  const CommentTile({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.cyan, width: 2.0),
      ),
      child: Text(comment.text!),
    );
  }
}
