import 'package:flutter/material.dart';
import 'package:hope_nest/views/profile/profile_page.dart';

class RouteGenerator {
  static Route<dynamic> initializeRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/HomePage':
        return MaterialPageRoute(
          builder: (_) => Container(),
        );

      case '/Profile':
        return MaterialPageRoute(
          builder: (_) => ProfilePage(),
        );
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