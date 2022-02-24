import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hope_nest/models/advert.dart';
import 'package:hope_nest/util/constants/navigation_constants.dart';
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
    final _advertsVM = Provider.of<List<Advert>>(context);
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(4.0),
      child: StaggeredGrid.count(
        crossAxisCount: 2,
        axisDirection: AxisDirection.down,
        mainAxisSpacing: 3.0,
        crossAxisSpacing: 4.0,
        children: _advertsVM
            .map<Widget>((advert) => StaggeredGridTile.fit(
                crossAxisCellCount: 1,
                child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, NavigationConstants.ADVERT,
                          arguments: advert);
                    },
                    child: Image.network("${advert.url}"))))
            .toList(),
      ),
    ));
  }
}
