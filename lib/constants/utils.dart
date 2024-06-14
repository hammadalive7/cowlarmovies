

import 'package:flutter/material.dart';

class DeviceUtils {
  static double getWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double getHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double getDynamicWidth(BuildContext context, double value) =>
      MediaQuery.of(context).size.width * value;

  static double getDynamicHeight(BuildContext context, double value) =>
      MediaQuery.of(context).size.height * value;
}
