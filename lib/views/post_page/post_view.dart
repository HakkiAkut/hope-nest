import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hope_nest/models/post.dart';
import 'package:hope_nest/util/enum/app_state.dart';
import 'package:hope_nest/util/methods/dynamic_size.dart';
import 'package:hope_nest/view_models/app_user_vm.dart';
import 'package:hope_nest/views/components/comment_list/comment_list.dart';
import 'package:hope_nest/views/components/owner_info_tile/owner_info_tile.dart';
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
    _appUserVM.getCommentAndOwner(pid: widget.post.id, uid: widget.post.uid);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Return Back"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: DynamicSize.width(context, 0.83),
              height: DynamicSize.height(context, 0.35),
              color: Colors.white,
              child: Image.network(widget.post.url!),
            ),
            Text(
              widget.post.title!,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Event ID:  ",
                  style: TextStyle(color: Colors.black38, fontSize: 12),
                ),
                Text(
                  widget.post.id!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ],
            ),
            SizedBox(
              height: DynamicSize.height(context, 0.03),
            ),
            _appUserVM.state == AppState.BUSY
                ? const CircularProgressIndicator()
                : OwnerInfoTile(appUser: _appUserVM.postOwner!),
            Container(
              width: DynamicSize.width(context, 0.93),
              height: DynamicSize.height(context, 0.11),
              child: Text(
                widget.post.description!,
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
            const CommentList(),
          ],
        ),
      ),
    );
  }
}
