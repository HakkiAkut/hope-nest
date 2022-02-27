import 'package:flutter/material.dart';
import 'package:hope_nest/models/app_user.dart';
import 'package:hope_nest/util/constants/navigation_constants.dart';
import 'package:hope_nest/util/enum/user_type.dart';
import 'package:hope_nest/views/components/owner_info_tile/circular_user_image.dart';

class OwnerInfoTile extends StatelessWidget {
  final AppUser appUser;
  final UserType userType;

  const OwnerInfoTile({Key? key, required this.appUser, required this.userType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircularUserImage(
        image: appUser.image != ""
            ? Image.network(
                appUser.image!,
              )
            : Image.asset("assets/user/user.png"),
      ),
      title: Text(appUser.name! + appUser.surname!),
      onTap: () {
        Navigator.pushNamed(context, NavigationConstants.PROFILE,
            arguments: userType);
      },
    );
  }
}
