import 'package:flutter/material.dart';
import 'package:hope_nest/models/post.dart';
import 'package:hope_nest/view_models/blog_vm.dart';
import 'package:hope_nest/views/home_page/blog/blog_view.dart';
import 'package:provider/provider.dart';

class BlogProvider extends StatelessWidget {
  const BlogProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _postsVM = Provider.of<BlogVM>(context);
    return StreamProvider<List<Post>>.value(
      value: _postsVM.getPosts(),
      initialData: const [],
      child: const BlogView(),
      updateShouldNotify: (prev, now) => true,
    );
  }
}
