import 'package:flutter/material.dart';
import 'package:hope_nest/models/advert.dart';
import 'package:hope_nest/view_models/advert_vm.dart';
import 'package:hope_nest/views/home_page/home/home_view.dart';
import 'package:provider/provider.dart';

class HomeProvider extends StatelessWidget {
  const HomeProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Advert>>.value(
      value: AdvertVM().getAdverts(),
      initialData: const [],
      child: const HomeViewPage(),
      updateShouldNotify: (prev, now) => true,
    );
  }
}
