import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hope_nest/models/advert.dart';
import 'package:hope_nest/models/app_user.dart';
import 'package:hope_nest/models/post.dart';
import 'package:hope_nest/util/enum/app_state.dart';
import 'package:hope_nest/util/methods/pick_image.dart';
import 'package:hope_nest/view_models/advert_vm.dart';
import 'package:hope_nest/view_models/app_user_vm.dart';
import 'package:hope_nest/view_models/blog_vm.dart';
import 'package:hope_nest/views/components/toast_message/toast_message.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SendPost {
  final _formKey = GlobalKey<FormState>();
  late File postImage;
  bool file = false;
  Post post =
      Post(url: '', uid: '', id: '', date: Timestamp.fromDate(DateTime.now()));

  dialog({required BuildContext context, required AppUser appUser}) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      useRootNavigator: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            final _appUserVM = Provider.of<AppUserVM>(context);
            return AlertDialog(
              title: const Text("Advert"),
              content: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Title",
                        ),
                        onSaved: (value) {
                          post.title = value;
                        },
                        validator: (value) {
                          if (value == null || value == '') {
                            return 'title cannot be empty!';
                          } else {
                            return null;
                          }
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Description",
                        ),
                        onSaved: (value) {
                          post.description = value;
                        },
                        validator: (value) {
                          if (value == null || value == '') {
                            return 'cannot be empty!';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      file == true ? Image.file(postImage):const SizedBox(),
                      TextButton(
                        onPressed: () async {
                          postImage = await PickImage().chooseFile();
                          file= true;
                          _appUserVM.state = AppState.IDLE;
                        },
                        child: Icon(Icons.perm_media_outlined),
                      ),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      post.uid = appUser.uid;
                      post.isBanned = false;
                      post.id = post.uid.substring(0, 5) +
                          post.date.seconds.toString();
                      postImage != null
                          ? post.url = postImage.path
                          : post.url = "";
                      bool? ret = await BlogVM().setPost(post: post);
                      if (ret != null || ret != false) {
                        getDoneMessage(text: "successful");
                      } else {
                        getErrorMessage(text: "an error occurred!");
                      }
                      Navigator.pop(context);
                    }
                  },
                  child: Text("Create"),
                )
              ],
            );
          },
        );
      },
    );
  }
}
