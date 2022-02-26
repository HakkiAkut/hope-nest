import 'package:flutter/material.dart';
import 'package:hope_nest/models/advert.dart';
import 'package:hope_nest/util/enum/app_state.dart';
import 'package:hope_nest/util/enum/user_type.dart';
import 'package:hope_nest/util/methods/dynamic_size.dart';
import 'package:hope_nest/view_models/app_user_vm.dart';
import 'package:hope_nest/views/components/advert_info_container/advert_info_container.dart';
import 'package:hope_nest/views/components/app_bar/app_bar.dart';
import 'package:hope_nest/views/components/image_container/image_container.dart';
import 'package:hope_nest/views/components/owner_info_tile/owner_info_tile.dart';
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
    _appUserVM.getAdvertOwner(id: widget.advert.uid);

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          ImageContainer(
            url: widget.advert.url,
            color: Colors.orangeAccent.shade200,
          ),
          Container(
            width: DynamicSize.width(context, 0.93),
            height: DynamicSize.height(context, 0.11),
            child: Text(
              widget.advert.description!,
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
          AdvertInfoContainer(advert: widget.advert),
          SizedBox(
            height: DynamicSize.height(context, 0.03),
          ),
          _appUserVM.state == AppState.BUSY
              ? const CircularProgressIndicator()
              : OwnerInfoTile(
                  appUser: _appUserVM.advertOwner!,
                  userType: UserType.advertOwner,
                )
        ],
      ),
    );
  }
}
