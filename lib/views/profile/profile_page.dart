import 'package:flutter/material.dart';
import 'package:hope_nest/util/enum/user_type.dart';
import 'package:hope_nest/view_models/app_user_vm.dart';
import 'package:hope_nest/views/components/app_bar/app_bar.dart';
import 'package:hope_nest/views/components/image_container/image_container.dart';
import 'package:provider/provider.dart';

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

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            ImageContainer(
                url: widget.userType == UserType.mainUser
                    ? _appUserVM.appUser!.image!
                    : (widget.userType == UserType.postOwner
                        ? _appUserVM.postOwner!.image!
                        : _appUserVM.advertOwner!.image!),
                color: Colors.white),
            Container(
              child: Text(widget.userType == UserType.mainUser
                  ? _appUserVM.appUser!.name!
                  : (widget.userType == UserType.postOwner
                      ? _appUserVM.postOwner!.name!
                      : _appUserVM.advertOwner!.name!)),
            ),
          ],
        ),
      ),
    );
  }
}
