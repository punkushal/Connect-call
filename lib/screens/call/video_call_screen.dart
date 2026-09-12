import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formatters.dart';
import '../../models/user_model.dart';
import '../../widgets/call_icon_button.dart';

class VideoCallScreen extends StatefulWidget {
  final UserModel peer;

  const VideoCallScreen({super.key, required this.peer});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  Timer? _ticker;
  Duration _elapsed = Duration.zero;
  bool _muted = false;
  bool _cameraOn = true;

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

  void _switchCamera() {
    // TODO: call calling_service.switchCamera() once the SDK is wired up.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Switched camera'),
        duration: Duration(milliseconds: 900),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.callBackground,
      body: Stack(
        children: [
          // background
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.callSurface, AppColors.callBackground],
                ),
              ),
            ),
          ),

          // small local preview
          Positioned(
            top: 76,
            right: 20,
            child: Container(
              width: 96,
              height: 132,
              decoration: BoxDecoration(
                color: AppColors.callSurfaceLight,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white24),
              ),
              child: Icon(
                _cameraOn ? Icons.person_rounded : Icons.videocam_off_rounded,
                color: Colors.white54,
                size: 34,
              ),
            ),
          ),

          // header + controls in normal layout
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.35),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.peer.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            formatDuration(_elapsed),
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CallIconButton(
                          icon: _muted
                              ? Icons.mic_off_rounded
                              : Icons.mic_rounded,
                          label: _muted ? 'Unmute' : 'Mute',
                          background: _muted
                              ? Colors.white
                              : AppColors.callSurfaceLight,
                          iconColor: _muted
                              ? AppColors.callBackground
                              : Colors.white,
                          onTap: () => setState(() => _muted = !_muted),
                        ),
                        CallIconButton(
                          icon: _cameraOn
                              ? Icons.videocam_rounded
                              : Icons.videocam_off_rounded,
                          label: _cameraOn ? 'Camera' : 'Camera off',
                          background: _cameraOn
                              ? AppColors.callSurfaceLight
                              : Colors.white,
                          iconColor: _cameraOn
                              ? Colors.white
                              : AppColors.callBackground,
                          onTap: () => setState(() => _cameraOn = !_cameraOn),
                        ),
                        CallIconButton(
                          icon: Icons.cameraswitch_rounded,
                          label: 'Switch',
                          onTap: _switchCamera,
                        ),
                        CallIconButton(
                          icon: Icons.call_end_rounded,
                          label: 'End',
                          background: AppColors.danger,
                          onTap: _endCall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
