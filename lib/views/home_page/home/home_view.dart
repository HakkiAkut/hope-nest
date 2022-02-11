import 'package:flutter/material.dart';
import 'package:hope_nest/models/advert.dart';
import 'package:provider/provider.dart';

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
      body: Container(child: Text(_advertsVM.first.id),)
    );
  }
}
