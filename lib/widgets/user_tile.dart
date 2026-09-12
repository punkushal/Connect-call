import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../models/user_model.dart';
import 'status_dot.dart';

class UserTile extends StatelessWidget {
  final UserModel user;
  final VoidCallback? onTap;
  final VoidCallback? onAudioCall;
  final VoidCallback? onVideoCall;

  const UserTile({
    super.key,
    required this.user,
    this.onTap,
    this.onAudioCall,
    this.onVideoCall,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        child: Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                  child: Text(
                    user.initials,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Positioned(
                  right: -1,
                  bottom: -1,
                  child: StatusDot(isOnline: user.isOnline),
                ),
              ],
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // user name
                  Text(
                    user.name,
                    style: const TextStyle(
                      fontSize: 15.5,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),

                  // user online status
                  Text(
                    user.isOnline ? 'Online' : 'Offline',
                    style: TextStyle(
                      fontSize: 13,
                      color: user.isOnline
                          ? AppColors.online
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            // audio call button
            _RoundIconButton(icon: Icons.call_rounded, onTap: onAudioCall),
            const SizedBox(width: 8),

            // video call button
            _RoundIconButton(icon: Icons.videocam_rounded, onTap: onVideoCall),
          ],
        ),
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _RoundIconButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primary.withValues(alpha: 0.1),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(9),
          child: Icon(icon, size: 19, color: AppColors.primary),
        ),
      ),
    );
  }
}
