import 'package:flutter/material.dart';
import 'package:hope_nest/util/enum/tabs.dart';
import 'package:hope_nest/view_models/app_user_vm.dart';
import 'package:hope_nest/views/components/navigation_bar.dart';
import 'package:provider/provider.dart';

class HomeRootPage extends StatefulWidget {
  const HomeRootPage({Key? key}) : super(key: key);

  @override
  _HomeRootPageState createState() => _HomeRootPageState();
}

class _HomeRootPageState extends State<HomeRootPage> {


  @override
  Widget build(BuildContext context) {
    final _appUserVM = Provider.of<AppUserVM>(context);
    return Scaffold(
      body: NavigationBar(current: _appUserVM.currentTab, selected: (Tabs selected){
        _appUserVM.currentTab = selected;
        print(_appUserVM.currentTab);
      }),
    );
  }
}
