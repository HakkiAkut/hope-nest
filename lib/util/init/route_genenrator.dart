import 'package:flutter/material.dart';
import 'package:hope_nest/models/advert.dart';
import 'package:hope_nest/models/post.dart';
import 'package:hope_nest/util/constants/navigation_constants.dart';
import 'package:hope_nest/views/advert_page/advert_view.dart';
import 'package:hope_nest/views/post_page/post_view.dart';
import 'package:hope_nest/views/profile/profile_page.dart';

class RouteGenerator {
  static Route<dynamic> initializeRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case NavigationConstants.HOME_PAGE:
        return MaterialPageRoute(
          builder: (_) => Container(),
        );

      case NavigationConstants.PROFILE:
        return MaterialPageRoute(
          builder: (_) => ProfilePage(),
        );

      case NavigationConstants.ADVERT:
        if (args is Advert) {
          return MaterialPageRoute(
            builder: (_) => AdvertView(
              advert: args,
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
