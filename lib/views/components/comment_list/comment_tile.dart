import 'package:flutter/material.dart';
import 'package:hope_nest/models/comment.dart';
import 'package:hope_nest/util/constants/palette.dart';

class CommentTile extends StatelessWidget {
  final Comment comment;

  const CommentTile({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 8),
      padding:  const EdgeInsets.all( 5),
      decoration: BoxDecoration(
        color: Palette.BACKGROUND,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.cyan, width: 2.0),
      ),
      child: Text(comment.text!),
    );
  }
}
