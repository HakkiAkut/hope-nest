import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hope_nest/util/constants/palette.dart';
import 'package:hope_nest/view_models/app_user_vm.dart';
import 'package:hope_nest/views/components/send_advert/send_advert.dart';
import 'package:provider/provider.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _appUserVM = Provider.of<AppUserVM>(context);
    return FloatingActionButton.extended(
      backgroundColor: Palette.MAIN_COLOR_BLUE,
      onPressed: () {
        print("Button is pressed.");
        SendAdvert().dialog(context: context, appUser: _appUserVM.appUser!);
      },
      label: const Text(
        "Share new Friend",
        style: TextStyle(color: Palette.BACKGROUND),
      ),
    );
  }
}
