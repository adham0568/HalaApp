import 'package:flutter/material.dart';
showSnackBar({required BuildContext context,required String text,required Color colors}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: Duration(seconds: 5),
    backgroundColor: colors,
    content: Text(text),
    action: SnackBarAction(label: "close", onPressed: () {}),
  ));
}