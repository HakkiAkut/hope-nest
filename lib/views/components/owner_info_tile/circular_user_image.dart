import 'package:flutter/material.dart';

class CircularUserImage extends StatelessWidget {
  final Image image;

  const CircularUserImage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: image,
    );
  }
}
