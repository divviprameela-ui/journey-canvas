import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppStyles {
  static const TextStyle sectionHeader = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryNavy,
    letterSpacing: -0.5,
  );

  static const TextStyle cardTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryNavy,
  );

  static const TextStyle cardDescription = TextStyle(
    fontSize: 12,
    color: Colors.blueGrey,
  );
}