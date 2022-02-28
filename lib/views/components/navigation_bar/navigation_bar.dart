import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hope_nest/util/constants/palette.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      indicatorColor: Colors.orange,
      unselectedLabelColor: Colors.black,
      labelColor: Palette.NAVBAR_BACKGROUND_HOVER_TEXT,
      indicator: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
        color: Palette.NAVBAR_BACKGROUND_HOVER,
      ),
      tabs: [
        Tab(
          text: "Home",
        ),
        Tab(
          text: "Blog",
        ),
        Tab(
          text: "Message",
        ),
      ],
    );
  }
}
