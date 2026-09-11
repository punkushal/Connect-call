import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';

class HeaderInfo extends StatelessWidget {
  final String title;
  final String subTitle;
  const HeaderInfo({super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 6,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          Text(
            subTitle,
            style: TextStyle(fontSize: 14.5, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
