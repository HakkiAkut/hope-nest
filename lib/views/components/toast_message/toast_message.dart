import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// error message
getErrorMessage({required String text}) {
  return Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

/// done message
getDoneMessage({required String text}) {
  return Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.greenAccent.withOpacity(0.8),
      textColor: Colors.black,
      fontSize: 16.0);
}
