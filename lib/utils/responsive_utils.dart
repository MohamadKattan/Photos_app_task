import 'package:flutter/material.dart';

import 'constants.dart';

class ResponsiveUtils {
  static checkResponsive(BuildContext context) {
    if (ResponsiveUtils.isMobile(context)) {
      columnsCount = 2;
      indexVariants = 2;
    } else if (ResponsiveUtils.isTablet(context)) {
      columnsCount = 3;
      indexVariants = 1;
    } else {
      columnsCount = 0;
    }
  }

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width <= 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width > 600 &&
      MediaQuery.of(context).size.width <= 1200;

  static bool isBigScreen(BuildContext context) =>
      MediaQuery.of(context).size.width > 1200;
}
