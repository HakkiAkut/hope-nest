import 'package:flutter/material.dart';
import 'package:hope_nest/util/constants/palette.dart';
import 'package:hope_nest/views/components/text_style.dart';

final buttonStyle = ButtonStyle(
  shape: MaterialStateProperty.all<OutlinedBorder>(const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
      side: BorderSide.none)),
  backgroundColor: MaterialStateProperty.all<Color>(Palette.MAIN_COLOR),
  elevation: MaterialStateProperty.all<double>(2.0),
  textStyle: MaterialStateProperty.all<TextStyle>(normalTextStyle),
  padding:
      MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(13.0)),
);
