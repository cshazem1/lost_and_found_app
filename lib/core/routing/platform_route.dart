import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Route<dynamic> platformRoute(Widget page) {
  if (Platform.isIOS) {
    return CupertinoPageRoute(builder: (_) => page);
  } else {
    return MaterialPageRoute(builder: (_) => page);
  }
}
