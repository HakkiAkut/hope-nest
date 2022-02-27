import 'package:flutter/material.dart';
import 'package:hope_nest/util/methods/dynamic_size.dart';

class CircularUserImage extends StatelessWidget {
  final Image image;

  const CircularUserImage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: DynamicSize.height(context, 0.065),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50.0),
        child: image,
      ),
    );
  }
}
