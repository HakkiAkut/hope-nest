import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hope_nest/models/post.dart';
import 'package:hope_nest/util/constants/palette.dart';
import 'package:hope_nest/util/enum/app_state.dart';
import 'package:hope_nest/util/enum/user_type.dart';
import 'package:hope_nest/util/methods/dynamic_size.dart';
import 'package:hope_nest/view_models/app_user_vm.dart';
import 'package:hope_nest/views/components/app_bar/app_bar.dart';
import 'package:hope_nest/views/components/comment_list/comment_list.dart';
import 'package:hope_nest/views/components/image_container/image_container.dart';
import 'package:hope_nest/views/components/owner_info_tile/owner_info_tile.dart';
import 'package:hope_nest/views/components/styles/background_style.dart';
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
    return Container(
      decoration: backgroundStyle,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const CustomAppBar(
          text: "Return Back",
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ImageContainer(
                url: widget.post.url!,
                color: Palette.BACKGROUND,
              ),
              SizedBox(
                height: DynamicSize.height(context, 0.016),
              ),
              Text(
                widget.post.title!,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Event ID:  ",
                    style: TextStyle(color: Colors.black38, fontSize: 10),
                  ),
                  Text(
                    widget.post.id!,
                    style: const TextStyle(fontSize: 10),
                  ),
                ],
              ),
              SizedBox(
                height: DynamicSize.height(context, 0.012),
              ),
              _appUserVM.state == AppState.BUSY
                  ? const CircularProgressIndicator()
                  : OwnerInfoTile(
                      appUser: _appUserVM.postOwner!,
                      userType: UserType.postOwner,
                    ),
              Container(
                width: DynamicSize.width(context, 0.93),
                child: Text(
                  widget.post.description!,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 11),
                ),
              ),
              SizedBox(
                height: DynamicSize.height(context, 0.012),
              ),
              const CommentList(),
            ],
          ),
        ),
      ),
    );
  }
}
