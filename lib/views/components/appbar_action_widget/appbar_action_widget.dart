import 'package:flutter/material.dart';
import 'package:hope_nest/util/constants/palette.dart';

class AppBarActionWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const AppBarActionWidget(
      {Key? key, required this.onPressed, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Palette.MAIN_COLOR_ORANGE,
            borderRadius: BorderRadius.circular(25)),
        child: Text(
          text,
          style: const TextStyle(color: Palette.BACKGROUND),
        ),
      ),
      onTap: () => onPressed.call(),
    );
  }
}
