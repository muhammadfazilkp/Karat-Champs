
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(
  String msg, {
  Color? color,
  Color? textColor,
  Toast? toastLength,
}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: toastLength ?? Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    webPosition: "center",
    timeInSecForIosWeb: 2,
    webShowClose: true,
    backgroundColor: color ?? Colors.red,
    textColor: textColor ?? Colors.white,
    fontSize: 14.0,
  );
}
