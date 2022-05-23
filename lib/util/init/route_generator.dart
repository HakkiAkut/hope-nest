import 'package:flutter/material.dart';
import 'package:hope_nest/models/advert.dart';
import 'package:hope_nest/models/app_user.dart';
import 'package:hope_nest/models/chatroom.dart';
import 'package:hope_nest/models/messages.dart';
import 'package:hope_nest/models/post.dart';
import 'package:hope_nest/util/constants/navigation_constants.dart';
import 'package:hope_nest/util/enum/user_type.dart';
import 'package:hope_nest/views/advert_page/advert_view.dart';
import 'package:hope_nest/views/home_page/messages/messages_provider.dart';
import 'package:hope_nest/views/post_page/post_view.dart';
import 'package:hope_nest/views/profile/profile_page.dart';
import 'package:hope_nest/views/report_page/report_page.dart';
import 'package:hope_nest/views/root.dart';

import '../../views/message/privMessage_provider.dart';

class RouteGenerator {
  static Route<dynamic> initializeRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case NavigationConstants.ROOT:
        return MaterialPageRoute(
          builder: (_) => RootPage(),
        );
      case NavigationConstants.HOME_PAGE:
        return MaterialPageRoute(
          builder: (_) => Container(),
        );

      case NavigationConstants.PROFILE:
        if (args is UserType) {
          return MaterialPageRoute(
            builder: (_) => ProfilePage(
              userType: args,
            ),
          );
        }
        return _errorRoute();

      case NavigationConstants.ADVERT:
        if (args is Advert) {
          return MaterialPageRoute(
            builder: (_) => AdvertView(
              advert: args,
            ),
          );
        }
        return _errorRoute();

      case NavigationConstants.MESSAGE:
        if (args is ChatRoom) {
          return MaterialPageRoute(
            builder: (_) => privMessage_provider(
             chatroom: args,
            ),
          );
        }
        return _errorRoute();

      case NavigationConstants.POST_PAGE:
        if (args is Post) {
          return MaterialPageRoute(
            builder: (_) => PostView(
              post: args,
            ),
          );
        }
        return _errorRoute();

      case NavigationConstants.REPORT:
        if (args is Advert) {
          return MaterialPageRoute(
            builder: (_) => ReportPage(
              reportAdvert: args,
            ),
          );
        } else if (args is AppUser) {
          return MaterialPageRoute(
            builder: (_) => ReportPage(
              reportUser: args,
            ),
          );
        }
        return _errorRoute();

      default:
        return _errorRoute();
    }
  }

  // error page
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Error'),
          ),
          body: const Center(
            child: Text('ERROR'),
          ),
        );
      },
    );
  }
}
