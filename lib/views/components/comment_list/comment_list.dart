import 'package:flutter/material.dart';
import 'package:hope_nest/view_models/app_user_vm.dart';
import 'package:hope_nest/util/enum/app_state.dart';
import 'package:hope_nest/views/components/comment_list/comment_tile.dart';
import 'package:provider/provider.dart';

class CommentList extends StatefulWidget {
  const CommentList({Key? key}) : super(key: key);

  @override
  _CommentListState createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  @override
  Widget build(BuildContext context) {
    final _appUserVM = Provider.of<AppUserVM>(context);
    return _appUserVM.state == AppState.BUSY
        ? const CircularProgressIndicator()
        : Container(
            color: Colors.transparent,
            child: ListView.builder(
              itemCount: _appUserVM.comments!.length,
              itemBuilder: (context, index) {
                return CommentTile(comment: _appUserVM.comments![index]);
              },
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            ),
          );
  }
}
