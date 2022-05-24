import 'package:flutter/material.dart';
import 'package:hope_nest/models/search.dart';
import 'package:hope_nest/services/notification/firebase/notification_service.dart';
import 'package:hope_nest/util/constants/navigation_constants.dart';
import 'package:hope_nest/util/constants/palette.dart';
import 'package:hope_nest/util/enum/user_type.dart';
import 'package:hope_nest/util/init/notifications.dart';
import 'package:hope_nest/util/methods/dynamic_size.dart';
import 'package:hope_nest/view_models/advert_vm.dart';
import 'package:hope_nest/view_models/app_user_vm.dart';
import 'package:hope_nest/view_models/blog_vm.dart';
import 'package:hope_nest/views/components/navigation_bar/navigation_bar.dart';
import 'package:hope_nest/views/components/owner_info_tile/circular_user_image.dart';
import 'package:hope_nest/views/components/search_filter/search_filter.dart';
import 'package:hope_nest/views/components/styles/input_style.dart';
import 'package:hope_nest/views/home_page/blog/blog_provider.dart';
import 'package:hope_nest/views/home_page/home/home_provider.dart';
import 'package:hope_nest/views/home_page/messages/messages_provider.dart';
import 'package:hope_nest/views/home_page/report_list_page/report_list_provider.dart';
import 'package:provider/provider.dart';

class HomeRootPage extends StatefulWidget {
  const HomeRootPage({Key? key}) : super(key: key);

  @override
  _HomeRootPageState createState() => _HomeRootPageState();
}

class _HomeRootPageState extends State<HomeRootPage> {
  @override
  void initState() {
    super.initState();
    FCMNotifications().getToken();
    NotificationInitializer.notification();
  }

  @override
  Widget build(BuildContext context) {
    final _appUserVM = Provider.of<AppUserVM>(context);
    final _advertVM = Provider.of<AdvertVM>(context);
    final _postsVM = Provider.of<BlogVM>(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                backgroundColor: Colors.white,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(10),
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25.0))),
                    margin: EdgeInsets.all(DynamicSize.height(context, 0.02)),
                    height: DynamicSize.height(context, 0.06),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Palette.NAVBAR_BACKGROUND,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0))),
                            child: const CustomNavigationBar(),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            child: CircularUserImage(
                              image: _appUserVM.appUser!.image != ""
                                  ? Image.network(
                                      _appUserVM.appUser!.image!,
                                    )
                                  : Image.asset("assets/user/user.png"),
                            ),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, NavigationConstants.PROFILE,
                                  arguments: UserType.mainUser);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ];
          },
          body: Column(
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: DynamicSize.height(context, 0.02)),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black),
                    readOnly: _appUserVM.currentIndex != 1 ? true : false,
                    controller: _appUserVM.tec,
                    decoration: inputStyle.copyWith(fillColor: Colors.white),
                    onChanged: (value) {
                      if (_appUserVM.currentIndex == 0) {
                        _advertVM.searchAdvert = SearchAdvert(location: value);
                      } else if (_appUserVM.currentIndex == 1) {
                        _postsVM.searchPost = SearchPost(title: value);
                      }
                      print(value);
                    },
                    onTap: () {
                      print(_appUserVM.currentIndex);
                      if (_appUserVM.currentIndex == 0) {
                        SearchFilter().searchAdvertDialog(context: context);
                      } else if (_appUserVM.currentIndex == 1) {
                        SearchFilter().searchPostDialog(context: context);
                      } else if (_appUserVM.currentIndex == 2 &&
                          _appUserVM.appUser!.isAdmin) {
                        SearchFilter().searchReportDialog(context: context);
                      }
                    },
                  ),
                ),
              ),
              Flexible(
                flex: 7,
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: DynamicSize.height(context, 0.03)),
                  child: TabBarView(
                    //physics: ScrollPhysics(),
                    children: [
                      const HomeProvider(),
                      const BlogProvider(),
                      _appUserVM.appUser!.isAdmin
                          ? const ReportListProvider()
                          : const MessagesProvider(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
