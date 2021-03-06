import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hope_nest/models/advert.dart';
import 'package:hope_nest/models/app_user.dart';
import 'package:hope_nest/util/enum/app_state.dart';
import 'package:hope_nest/util/methods/pick_image.dart';
import 'package:hope_nest/view_models/advert_vm.dart';
import 'package:hope_nest/view_models/app_user_vm.dart';
import 'package:hope_nest/views/components/toast_message/toast_message.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SendAdvert {
  final _formKey = GlobalKey<FormState>();
  late File postImage;
  bool file=false;
  Advert advert = Advert(
      url: '',
      uid: '',
      id: '',
      date: Timestamp.fromDate(DateTime.now()));

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
                          labelText: "Name",
                        ),
                        onSaved: (value) {
                          advert.name = value;
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
                        decoration: const InputDecoration(
                          labelText: "Description",
                        ),
                        onSaved: (value) {
                          advert.description = value;
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
                        decoration: const InputDecoration(
                          labelText: "Kind",
                        ),
                        onSaved: (value) {
                          advert.kind = value;
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
                        decoration: const InputDecoration(
                          labelText: "Race",
                        ),
                        onSaved: (value) {
                          advert.race = value;
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
                        decoration: const InputDecoration(
                          hintText: "Only Digit",
                          labelText: "Age",
                        ),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onSaved: (value) {
                          advert.age = int.parse(value!);
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
                        decoration: const InputDecoration(
                          hintText: "Only Digit",
                          labelText: "Weight",
                        ),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onSaved: (value) {
                          advert.weight = double.parse(value!);
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
                      Container(
                        width: 221,
                        height: 30,
                        child: ToggleSwitch(
                          minWidth: 110,
                          minHeight: 30.0,
                          fontSize: 13.0,
                          initialLabelIndex: 1,
                          activeBgColor: [Colors.green],
                          activeFgColor: Colors.white,
                          inactiveBgColor: Colors.grey,
                          inactiveFgColor: Colors.grey[900],
                          totalSwitches: 2,
                          labels: const ['Not Trained', 'Trained'],
                          onToggle: (index) {
                            advert.training = index == 0 ? false : true;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 221,
                        height: 30,
                        child: ToggleSwitch(
                          minWidth: 110,
                          minHeight: 30.0,
                          fontSize: 13.0,
                          initialLabelIndex: 1,
                          activeBgColor: [Colors.green],
                          activeFgColor: Colors.white,
                          inactiveBgColor: Colors.grey,
                          inactiveFgColor: Colors.grey[900],
                          totalSwitches: 2,
                          labels: const ['Not Vaccinated', ' Vaccinated'],
                          onToggle: (index) {
                            advert.vaccines = index == 0 ? false : true;
                          },
                        ),
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
                      advert.uid = appUser.uid;
                      advert.isBanned = false;
                      advert.location = appUser.location;
                      advert.id = advert.uid.substring(0, 5) +
                          advert.date.seconds.toString();
                      postImage != null
                          ? advert.url = postImage.path
                          : advert.url = "";
                      bool? ret = await AdvertVM().setAdvert(advert: advert);
                      if(ret != null || ret != false){
                        getDoneMessage( text: "successful");
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
