import 'package:flutter/material.dart';
import 'package:hope_nest/util/constants/palette.dart';
import 'package:hope_nest/view_models/app_user_vm.dart';
import 'package:provider/provider.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const CustomFloatingActionButton({Key? key, required this.onPressed, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final _appUserVM = Provider.of<AppUserVM>(context);
    return FloatingActionButton.extended(
      backgroundColor: Palette.MAIN_COLOR_BLUE,
      onPressed: () => onPressed.call(),
      label:  Text(
        text,
        style: const TextStyle(color: Palette.BACKGROUND),
      ),
    );
  }
}
