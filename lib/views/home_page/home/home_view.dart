import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hope_nest/models/advert.dart';
import 'package:hope_nest/util/constants/navigation_constants.dart';
import 'package:hope_nest/util/constants/palette.dart';
import 'package:hope_nest/util/methods/dynamic_size.dart';
import 'package:hope_nest/view_models/app_user_vm.dart';
import 'package:hope_nest/views/components/custom_floating_action_button/custom_floating_action_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeViewPage extends StatefulWidget {
  const HomeViewPage({Key? key}) : super(key: key);

  @override
  _HomeViewPageState createState() => _HomeViewPageState();
}

class _HomeViewPageState extends State<HomeViewPage> {

  @override
  Widget build(BuildContext context) {
    final _appUserVM = Provider.of<AppUserVM>(context);
    final _advertsVM = Provider.of<List<Advert>>(context);
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: const CustomFloatingActionButton(),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(4.0),
          child: StaggeredGrid.count(
            crossAxisCount: 2,
            axisDirection: AxisDirection.down,
            mainAxisSpacing: DynamicSize.height(context, 0.035),
            crossAxisSpacing: DynamicSize.width(context, 0.09),
            children: _advertsVM
                .map<Widget>((advert) => StaggeredGridTile.fit(
                      crossAxisCellCount: 1,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, NavigationConstants.ADVERT,
                              arguments: advert);
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Palette.MAIN_COLOR_ORANGE,
                                borderRadius: BorderRadius.circular(25)),
                            padding: EdgeInsets.all(
                                DynamicSize.width(context, 0.016)),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: Image.network(advert.url),
                                ),
                                Text(
                                  advert.name!,
                                  style: const TextStyle(color: Colors.white),
                                )
                              ],
                            )),
                      ),
                    ))
                .toList(),
          ),
        ));
  }
}
