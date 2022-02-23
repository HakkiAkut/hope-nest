import 'package:flutter/material.dart';
import 'package:hope_nest/models/post.dart';
import 'package:provider/provider.dart';

class BlogView extends StatefulWidget {
  const BlogView({Key? key}) : super(key: key);

  @override
  _BlogViewState createState() => _BlogViewState();
}

class _BlogViewState extends State<BlogView> {
  @override
  Widget build(BuildContext context) {
    final _postsVM = Provider.of<List<Post>>(context);
    return Scaffold(
      body: Center(
        child: Text("${_postsVM.first.title}"),
      ),
    );
  }
}
