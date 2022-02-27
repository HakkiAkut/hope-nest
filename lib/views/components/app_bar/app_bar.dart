import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hope_nest/util/constants/palette.dart';
import 'package:hope_nest/util/methods/dynamic_size.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? actionWidget;

  const CustomAppBar({Key? key, this.actionWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: DynamicSize.height(context, 0.03),right: DynamicSize.width(context, 0.04),left: DynamicSize.width(context, 0.04)),
      color: Colors.white,
      child: Row(
        children: [
          GestureDetector(
            child: const Icon(Icons.arrow_back_ios,
                color: Palette.MAIN_COLOR_BLUE),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Text(
            "Return Back",
            style: TextStyle(fontSize: 20, color: Palette.MAIN_COLOR_BLUE),
          ),
          isNull(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(40);

  Widget isNull() {
    if (actionWidget == null) {
      return Container();
    } else {
      return actionWidget!;
    }
  }
}
