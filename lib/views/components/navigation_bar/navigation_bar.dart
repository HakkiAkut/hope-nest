import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationBar extends StatelessWidget {
  const NavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      indicatorColor: Colors.blue,
      unselectedLabelColor: Colors.grey,
      labelColor: Colors.blue,
      indicator: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
        color: Colors.green,
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
