import 'package:flutter/material.dart';
import 'package:hope_nest/models/advert.dart';
import 'package:hope_nest/util/enum/app_state.dart';
import 'package:hope_nest/view_models/app_user_vm.dart';
import 'package:provider/provider.dart';

class AdvertView extends StatefulWidget {
  final Advert advert;

  const AdvertView({Key? key, required this.advert}) : super(key: key);

  @override
  _AdvertViewState createState() => _AdvertViewState();
}

class _AdvertViewState extends State<AdvertView> {
  @override
  Widget build(BuildContext context) {
    final _appUserVM = Provider.of<AppUserVM>(context);
    _appUserVM.getOwner(widget.advert.uid);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Return Back"),
      ),
      body: Center(
          child: _appUserVM.state == AppState.BUSY
              ? const CircularProgressIndicator()
              : Text(_appUserVM.advertOwner!.uid)),
    );
  }
}
