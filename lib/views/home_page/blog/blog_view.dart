import 'package:flutter/material.dart';
import 'package:hope_nest/models/post.dart';
import 'package:hope_nest/view_models/app_user_vm.dart';
import 'package:hope_nest/views/components/custom_floating_action_button/custom_floating_action_button.dart';
import 'package:hope_nest/views/components/post_list_container/post_list_container.dart';
import 'package:hope_nest/views/components/send_post/send_post.dart';
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
    final _appUserVM = Provider.of<AppUserVM>(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomFloatingActionButton(
          text: "Share new Post",
          onPressed: () => SendPost()
              .dialog(context: context, appUser: _appUserVM.appUser!)),
      backgroundColor: Colors.transparent,
      body: ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: _postsVM.length,
          itemBuilder: (BuildContext context, int index) {
            return PostListContainer(post: _postsVM[index]);
          }),
    );
  }
}
