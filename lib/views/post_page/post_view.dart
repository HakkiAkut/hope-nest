import 'package:flutter/material.dart';
import 'package:hope_nest/models/post.dart';
import 'package:hope_nest/util/enum/app_state.dart';
import 'package:hope_nest/view_models/app_user_vm.dart';
import 'package:provider/provider.dart';

class PostView extends StatefulWidget {
  final Post post;

  const PostView({Key? key, required this.post}) : super(key: key);

  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  @override
  Widget build(BuildContext context) {
    final _appUserVM = Provider.of<AppUserVM>(context);
    _appUserVM.getComment(pid: widget.post.id);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Return Back"),
      ),
      body: Center(
          child: _appUserVM.state == AppState.BUSY
              ? const CircularProgressIndicator()
              : Text(_appUserVM.comments!.first.id)),
    );
  }
}
