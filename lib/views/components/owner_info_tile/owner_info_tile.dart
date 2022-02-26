import 'package:flutter/material.dart';
import 'package:hope_nest/models/app_user.dart';
import 'package:hope_nest/util/constants/navigation_constants.dart';
import 'package:hope_nest/util/enum/user_type.dart';

class OwnerInfoTile extends StatelessWidget {
  final AppUser appUser;
  final UserType userType;

  const OwnerInfoTile({Key? key, required this.appUser, required this.userType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: appUser.image != ""
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
