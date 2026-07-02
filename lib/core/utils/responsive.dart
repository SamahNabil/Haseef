import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';

class Responsive {
  const Responsive._();

  static double horizontalPadding(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= 900) return width * 0.18;
    if (width >= 600) return width * 0.12;
    return AppSpacing.screenHorizontal;
  }

  static int gridCrossAxisCount(BuildContext context, {int mobile = 2}) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= 900) return 3;
    return mobile;
  }

  static double contentMaxWidth(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= 900 ? 720 : width;
  }
}
