import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hope_nest/models/tab_item_data.dart';
import 'package:hope_nest/util/enum/tabs.dart';

BottomNavigationBarItem tabItem({required Tabs tab}) {
  final TabItemData? currentItem = TabItemData.tabs[tab];
  return BottomNavigationBarItem(
    label: currentItem!.title,
    icon: Icon(currentItem.icon),
  );
}



