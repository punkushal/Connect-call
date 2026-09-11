import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class StatusDot extends StatelessWidget {
  final bool isOnline;
  final double size;

  const StatusDot({super.key, required this.isOnline, this.size = 10});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: isOnline ? AppColors.online : AppColors.offline,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1.5),
      ),
    );
  }
}
