import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hope_nest/util/constants/palette.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: Palette.MAIN_COLOR_BLUE,
      onPressed: () {
        print("Button is pressed.");
        //task to execute when this button is pressed
      },
      label: const Text(
        "Share new Friend",
        style: TextStyle(color: Palette.BACKGROUND),
      ),
    );
  }
}
