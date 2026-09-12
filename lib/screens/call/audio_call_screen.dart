import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formatters.dart';
import '../../models/user_model.dart';
import '../../widgets/call_icon_button.dart';

class AudioCallScreen extends StatefulWidget {
  final UserModel peer;

  const AudioCallScreen({super.key, required this.peer});

  @override
  State<AudioCallScreen> createState() => _AudioCallScreenState();
}

class _AudioCallScreenState extends State<AudioCallScreen> {
  Timer? _ticker;
  Duration _elapsed = Duration.zero;
  bool _muted = false;
  bool _speakerOn = false;

  // TODO: replace with real state from calling_service (calling -> ringing
  // -> connected -> ended) instead of assuming an instant connection.
  final String _status = 'Connected';

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _elapsed += const Duration(seconds: 1));
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  void _endCall() => Navigator.of(context).pop();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.callBackground,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Text(
              _status,
              style: const TextStyle(color: Colors.white54, fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(
              widget.peer.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              formatDuration(_elapsed),
              style: const TextStyle(color: Colors.white70, fontSize: 15),
            ),
            const Spacer(),
            CircleAvatar(
              radius: 72,
              backgroundColor: AppColors.callSurface,
              child: Text(
                widget.peer.initials,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CallIconButton(
                    icon: _muted ? Icons.mic_off_rounded : Icons.mic_rounded,
                    label: _muted ? 'Unmute' : 'Mute',
                    background: _muted
                        ? Colors.white
                        : AppColors.callSurfaceLight,
                    iconColor: _muted ? AppColors.callBackground : Colors.white,
                    onTap: () => setState(() => _muted = !_muted),
                  ),
                  CallIconButton(
                    icon: Icons.call_end_rounded,
                    label: 'End',
                    background: AppColors.danger,
                    onTap: _endCall,
                    size: 66,
                  ),
                  CallIconButton(
                    icon: _speakerOn
                        ? Icons.volume_up_rounded
                        : Icons.volume_down_rounded,
                    label: 'Speaker',
                    background: _speakerOn
                        ? Colors.white
                        : AppColors.callSurfaceLight,
                    iconColor: _speakerOn
                        ? AppColors.callBackground
                        : Colors.white,
                    onTap: () => setState(() => _speakerOn = !_speakerOn),
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
