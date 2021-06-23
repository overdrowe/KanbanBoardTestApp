import 'package:flutter/material.dart';

class AppStyle {
  Color mainColor = Color(0xFF64FFD8);

  static final AppStyle _appStyle = AppStyle._internal();

  factory AppStyle() {
    return _appStyle;
  }

  AppStyle._internal();
}
