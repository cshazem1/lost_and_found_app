import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Route<dynamic> platformRoute({required Widget child}) {
  if (Platform.isIOS) {
    return CupertinoPageRoute(builder: (_) => child);
  } else {
    return MaterialPageRoute(builder: (_) => child);
  }
}
