import 'package:flutter/material.dart';

class responsiveLayout {
  static const int phoneLimit = 800;

  static bool isPhone(BuildContext context) =>
      MediaQuery.of(context).size.width < phoneLimit;

  static bool isTab(BuildContext context) =>
      MediaQuery.of(context).size.width >= phoneLimit;
}
