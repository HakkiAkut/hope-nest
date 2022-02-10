import 'package:flutter/material.dart';
import 'package:hope_nest/util/enum/tabs.dart';

class TabItemData {
  final String title;
  final IconData icon;

  TabItemData({required this.title, required this.icon});
  static Map<Tabs, TabItemData> tabs = {
    Tabs.home : TabItemData(title: "Home" ,icon: Icons.home),
    Tabs.posts : TabItemData(title: "Posts" ,icon: Icons.home),
    Tabs.messages : TabItemData(title: "Messages" ,icon: Icons.home)
  };
}