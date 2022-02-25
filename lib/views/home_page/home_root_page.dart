import 'package:flutter/material.dart';
import 'package:hope_nest/view_models/app_user_vm.dart';
import 'package:hope_nest/views/components/navigation_bar/navigation_bar.dart';
import 'package:hope_nest/views/home_page/blog/blog_provider.dart';
import 'package:hope_nest/views/home_page/home/home_provider.dart';
import 'package:hope_nest/views/home_page/messages/messages_provider.dart';
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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
            margin: EdgeInsets.all(5.0),
            height: 50.0,
            child: Row(
              children: const [
                Expanded(
                  flex: 5,
                  child: NavigationBar(),
                ),
                Expanded(
                  flex: 1,
                  child: Icon(Icons.add),
                )
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            HomeProvider(),
            BlogProvider(),
            MessagesProvider(),
          ],
        ),
      ),
    );
  }
}
