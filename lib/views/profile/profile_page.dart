import 'package:flutter/material.dart';
import 'package:hope_nest/util/enum/user_type.dart';
import 'package:hope_nest/views/components/app_bar/app_bar.dart';

class ProfilePage extends StatefulWidget {
  final UserType userType;

  const ProfilePage({Key? key, required this.userType}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
    );
  }
}
