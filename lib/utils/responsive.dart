import 'package:flutter/material.dart';

class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
          MediaQuery.of(context).size.width < 1024;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;

  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double scaleFont(
      BuildContext context, {
        required double mobile,
        double? tablet,
        double? desktop,
      }) {
    if (isDesktop(context)) {
      return desktop ?? mobile * 1.4;
    }

    if (isTablet(context)) {
      return tablet ?? mobile * 1.2;
    }

    return mobile;
  }

  static double scaleSize(
      BuildContext context, {
        required double mobile,
        double? tablet,
        double? desktop,
      }) {
    if (isDesktop(context)) {
      return desktop ?? mobile * 1.5;
    }

    if (isTablet(context)) {
      return tablet ?? mobile * 1.25;
    }

    return mobile;
  }

  static int gridCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width >= 1024) {
      return 4;
    }

    if (width >= 600) {
      return 3;
    }

    return 2;
  }
}