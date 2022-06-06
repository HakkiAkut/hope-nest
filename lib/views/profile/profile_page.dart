import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hope_nest/models/advert.dart';
import 'package:hope_nest/models/app_user.dart';
import 'package:hope_nest/models/chatroom.dart';
import 'package:hope_nest/util/constants/navigation_constants.dart';
import 'package:hope_nest/util/constants/palette.dart';
import 'package:hope_nest/util/enum/user_type.dart';
import 'package:hope_nest/util/methods/dynamic_size.dart';
import 'package:hope_nest/view_models/advert_vm.dart';
import 'package:hope_nest/view_models/app_user_vm.dart';
import 'package:hope_nest/view_models/chatRoom_vm.dart';
import 'package:hope_nest/views/components/app_bar/app_bar.dart';
import 'package:hope_nest/views/components/appbar_action_widget/appbar_action_widget.dart';
import 'package:hope_nest/views/components/image_container/image_container.dart';
import 'package:hope_nest/views/components/styles/background_style.dart';
import 'package:hope_nest/views/home_page/home/home_view.dart';
import 'package:provider/provider.dart';

import '../components/custom_floating_action_button/custom_floating_action_button.dart';

class ProfilePage extends StatefulWidget {
  final UserType userType;

  const ProfilePage({Key? key, required this.userType}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final _appUserVM = Provider.of<AppUserVM>(context);
    final chatroomvm = Provider.of<ChatRoomVM>(context);
    AppUser _appUser = widget.userType == UserType.mainUser
        ? _appUserVM.appUser!
        : (widget.userType == UserType.postOwner
            ? _appUserVM.postOwner!
            : _appUserVM.advertOwner!);

    return Container(
      decoration: backgroundStyle,
      height: DynamicSize.height(context, 1),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: (widget.userType == UserType.mainUser ||
                _appUser.uid == _appUserVM.appUser!.uid)
            ? Container()
            : CustomFloatingActionButton(
                text: "Send Message",
                onPressed: () async {
                  //chatroom object
                  ChatRoom chatroom = ChatRoom(
                      id: _appUserVM.appUser!.uid + _appUser.uid,
                      last_message: '',
                      names: [_appUserVM.appUser!.name, _appUser.name],
                      users: [_appUser.uid, _appUserVM.appUser!.uid],
                      time: Timestamp.fromDate(DateTime.now()));

                  bool? x = await chatroomvm.setChatRoom(chatroom: chatroom);
                  print(x);
                  if (x != null && x) {
                    print("OPENCHATROOM");
                    Navigator.pushNamed(context, NavigationConstants.MESSAGE,
                        arguments: chatroom);
                  }

                  // if true return nav with chatroom
                }),
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          text: "Return Back",
          actionWidget: widget.userType == UserType.mainUser
              ? AppBarActionWidget(
                  onPressed: () {
                    _appUserVM.signOut();
                    Navigator.pop(context);
                  },
                  text: "Log Out")
              : AppBarActionWidget(
                  onPressed: () {
                    Navigator.pushNamed(context, NavigationConstants.REPORT,
                        arguments: _appUser);
                  },
                  text: "report",
                ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: DynamicSize.height(context, 1.3),
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                ImageContainer(
                  url: _appUser.image!,
                  color: Colors.transparent,
                  radius: 50,
                ),
                Text(
                    _appUser.name! +
                        " " +
                        _appUser.surname! +
                        ", " +
                        _appUser.location!,
                    style: TextStyle(color: Colors.grey.shade500)),
                SizedBox(height: DynamicSize.height(context, 0.012)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    _appUser.description!,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                SizedBox(height: DynamicSize.height(context, 0.015)),
                Text(
                  "Adverts",
                  style: TextStyle(color: Colors.grey.shade500),
                ),
                Container(
                  height: DynamicSize.height(context, 0.8),
                  child: StreamProvider<List<Advert>>.value(
                    value: AdvertVM().getAdvertsByUID(uid: _appUser.uid),
                    initialData: const [],
                    child: const HomeViewPage(),
                    updateShouldNotify: (prev, now) => true,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
