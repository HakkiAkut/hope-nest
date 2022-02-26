import 'package:flutter/material.dart';
import 'package:hope_nest/util/methods/dynamic_size.dart';

class ImageContainer extends StatelessWidget {
  final String url;
  final String? alt;
  final Color color;

  const ImageContainer(
      {Key? key, required this.url, this.alt, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: DynamicSize.width(context, 1),
      height: DynamicSize.height(context, 0.35),
      color: color,
      child:
          url != "" ? Image.network(url) : Image.asset("assets/user/user.png"),
    );
  }
}
