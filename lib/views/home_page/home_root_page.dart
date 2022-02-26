import 'package:flutter/material.dart';
import 'package:hope_nest/util/constants/palette.dart';
import 'package:hope_nest/util/methods/dynamic_size.dart';
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
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
            margin: EdgeInsets.all(DynamicSize.height(context, 0.03)),
            height: DynamicSize.height(context, 0.06),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Palette.NAVBAR_BACKGROUND,
                        borderRadius: BorderRadius.all(Radius.circular(25.0))),
                    child: const NavigationBar(),
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: Icon(Icons.add),
                )
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: DynamicSize.height(context, 0.03)),
              child: const TabBarView(
                children: [
                  HomeProvider(),
                  BlogProvider(),
                  MessagesProvider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
