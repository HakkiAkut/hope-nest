import 'package:flutter/material.dart';

class InfoTexts extends StatelessWidget {
  final String title;
  final String info;

  const InfoTexts({Key? key, required this.title, required this.info})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        Text(
          info,
          style: const TextStyle(fontSize: 14),
        )
      ],
    );
  }
}
