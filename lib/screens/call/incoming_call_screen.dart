import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../models/call_model.dart';
import '../../models/user_model.dart';
import 'audio_call_screen.dart';
import 'video_call_screen.dart';

class IncomingCallScreen extends StatelessWidget {
  final UserModel caller;
  final CallType type;

  const IncomingCallScreen({
    super.key,
    required this.caller,
    required this.type,
  });

  void _decline(BuildContext context) => Navigator.of(context).pop();

  void _accept(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => type == CallType.video
            ? VideoCallScreen(peer: caller)
            : AudioCallScreen(peer: caller),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final label = type == CallType.video
        ? 'Incoming Video Call'
        : 'Incoming Audio Call';

    return Scaffold(
      backgroundColor: AppColors.callBackground,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 56),
            Text(
              label,
              style: const TextStyle(color: Colors.white60, fontSize: 15),
            ),
            const SizedBox(height: 8),
            Text(
              caller.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            CircleAvatar(
              radius: 76,
              backgroundColor: AppColors.callSurface,
              child: Text(
                caller.initials,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 42,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _RoundAction(
                    icon: Icons.call_end_rounded,
                    label: 'Decline',
                    color: AppColors.danger,
                    onTap: () => _decline(context),
                  ),
                  _RoundAction(
                    icon: Icons.call_rounded,
                    label: 'Accept',
                    color: AppColors.online,
                    onTap: () => _accept(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoundAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _RoundAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: color,
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onTap,
            child: SizedBox(
              width: 68,
              height: 68,
              child: Icon(icon, color: Colors.white, size: 30),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 13),
        ),
      ],
    );
  }
}
