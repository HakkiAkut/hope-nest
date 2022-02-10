import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hope_nest/util/enum/tabs.dart';
import 'package:hope_nest/views/components/tab_item.dart';

class NavigationBar extends StatelessWidget {
  const NavigationBar({Key? key, required this.current, required this.selected})
      : super(key: key);

  final Tabs current;
  final ValueChanged<Tabs> selected;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        iconSize: 0,
        items: [
          tabItem(tab: Tabs.home),
          tabItem(tab: Tabs.posts),
          tabItem(tab: Tabs.messages)
        ],
        onTap: (index)=> selected(Tabs.values[index]),
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (context)=> Container(child: Text("child"),),
        );
      },
    );
  }
}
