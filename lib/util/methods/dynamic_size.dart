import 'package:flutter/material.dart';

class DynamicSize{
  static double height(BuildContext context, double ratio) {
    return MediaQuery.of(context).size.height * ratio;
  }
  static double width(BuildContext context, double ratio) {
    return MediaQuery.of(context).size.width * ratio;
  }
}