import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

/// A circular icon + label control, used for mute/speaker/camera/end-call
/// buttons on the audio, video, and incoming-call screens.
class CallIconButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color background;
  final Color iconColor;
  final double size;

  const CallIconButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.background = AppColors.callSurfaceLight,
    this.iconColor = Colors.white,
    this.size = 58,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: background,
          shape: const CircleBorder(),
          child: InkWell(
            onTap: onTap,
            customBorder: const CircleBorder(),
            child: SizedBox(
              width: size,
              height: size,
              child: Icon(icon, color: iconColor, size: size * 0.42),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12.5),
        ),
      ],
    );
  }
}
