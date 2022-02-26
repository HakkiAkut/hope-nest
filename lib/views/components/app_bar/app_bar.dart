import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? actionWidget;

  const CustomAppBar({Key? key, this.actionWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        child: const Icon(Icons.arrow_back_ios),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      title: const Text("Return Back"),
      actions: <Widget>[isNull()],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  Widget isNull() {
    if (actionWidget == null) {
      return Container();
    } else {
      return actionWidget!;
    }
  }
}
