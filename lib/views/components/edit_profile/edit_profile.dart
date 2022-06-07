import 'dart:io';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hope_nest/models/app_user.dart';
import 'package:hope_nest/util/enum/app_state.dart';
import 'package:hope_nest/util/methods/pick_image.dart';
import 'package:hope_nest/view_models/app_user_vm.dart';
import 'package:hope_nest/views/components/toast_message/toast_message.dart';
import 'package:provider/provider.dart';

class EditProfile {
  final _formKey = GlobalKey<FormState>();
  late File postImage;
  bool file = false;

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
              title: const Text("Edit Profile"),
              content: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: appUser.name,
                        decoration: const InputDecoration(
                          labelText: "Name",
                        ),
                        onSaved: (value) {
                          appUser.name = value;
                        },
                        validator: (value) {
                          if (value == null || value == '') {
                            return 'cannot be empty!';
                          } else {
                            return null;
                          }
                        },
                      ),
                      TextFormField(
                        initialValue: appUser.surname,
                        decoration: const InputDecoration(
                          labelText: "Surname",
                        ),
                        onSaved: (value) {
                          appUser.surname = value;
                        },
                        validator: (value) {
                          if (value == null || value == '') {
                            return 'cannot be empty!';
                          } else {
                            return null;
                          }
                        },
                      ),
                      TextFormField(
                        initialValue: appUser.description,
                        decoration: const InputDecoration(
                          labelText: "About",
                        ),
                        onSaved: (value) {
                          appUser.description = value;
                        },
                        validator: (value) {
                          if (value == null || value == '') {
                            return 'cannot be empty!';
                          } else {
                            return null;
                          }
                        },
                      ),
                      DropdownSearch<String>(
                          showSearchBox: true,
                          mode: Mode.MENU,
                          showSelectedItems: true,
                          items: const [
                            "Ankara",
                            "Antalya",
                            "Bursa",
                            'Istanbul'
                          ],
                          dropdownSearchDecoration: const InputDecoration(
                            labelText: "Location",
                          ),
                          onChanged: (value) {
                            appUser.location = value;
                            print(appUser.location);
                          },
                          selectedItem: appUser.location),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Phone 5** *** ****",
                          labelText: "Weight",
                        ),
                        initialValue: appUser.phone,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onSaved: (value) {
                          appUser.phone = value;
                        },
                        validator: (value) {
                          if (value == null || value == '') {
                            return 'cannot be empty!';
                          } else {
                            return null;
                          }
                        },
                      ),
                      file == true ? Image.file(postImage) : const SizedBox(),
                      TextButton(
                        onPressed: () async {
                          postImage = await PickImage().chooseFile();
                          file = true;
                          _appUserVM.state = AppState.IDLE;
                        },
                        child: const Icon(Icons.perm_media_outlined),
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
                      if (file == true) {
                        print("deneme12312312312 fil");
                        appUser.image = await _appUserVM.uploadFile(
                            uid: appUser.uid, uploadedFile: postImage);
                      }
                      bool? ret = await _appUserVM.setUser(appUser: appUser);
                      if (ret != null || ret != false) {
                        _appUserVM.currentUser();
                        getDoneMessage(text: "successful");
                      } else {
                        getErrorMessage(text: "an error occurred!");
                      }
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Edit"),
                )
              ],
            );
          },
        );
      },
    );
  }
}
