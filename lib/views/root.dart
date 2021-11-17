import 'package:flutter/material.dart';
import 'package:hope_nest/util/enum/app_state.dart';
import 'package:hope_nest/view_models/app_user_vm.dart';
import 'package:hope_nest/views/home_page/home_page.dart';
import 'package:hope_nest/views/login/login_page.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class RootPage extends StatelessWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _appUserVM = Provider.of<AppUserVM>(context);
    if (_appUserVM.state == AppState.IDLE) {
      return _appUserVM.appUser != null
          ? const HomePage() : const LoginPage();
    } else {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}