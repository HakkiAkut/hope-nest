import 'package:flutter/material.dart';
import 'package:hope_nest/models/post.dart';

class PostView extends StatefulWidget {
  final Post post;

  const PostView({Key? key, required this.post}) : super(key: key);

  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
