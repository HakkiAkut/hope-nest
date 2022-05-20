import 'package:flutter/material.dart';
import 'package:hope_nest/util/constants/palette.dart';
import 'package:hope_nest/view_models/app_user_vm.dart';
import 'package:provider/provider.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _appUserVM = Provider.of<AppUserVM>(context);
    return  TabBar(
      indicatorColor: Colors.orange,
      unselectedLabelColor: Colors.black,
      labelColor: Palette.NAVBAR_BACKGROUND_HOVER_TEXT,
      indicator: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
        color: Palette.NAVBAR_BACKGROUND_HOVER,
      ),
      tabs: [
        const Tab(
          text: "Home",
        ),
        const Tab(
          text: "Blog",
        ),
        Tab(
          text: _appUserVM.appUser!.isAdmin ? "Reports" : "Message",
        ),
      ],
    );
  }
}
