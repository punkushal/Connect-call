import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formatters.dart';
import '../../data/mock_data.dart';
import '../../models/call_model.dart';
import '../call/audio_call_screen.dart';
import '../call/video_call_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final history = MockData.callHistory;

    return Scaffold(
      appBar: AppBar(title: const Text('Calls'), centerTitle: true),
      body: history.isEmpty
          ? const Center(
              child: Text(
                'No calls yet.',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              itemCount: history.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, i) {
                final item = history[i];
                return _HistoryRow(item: item);
              },
            ),
    );
  }
}

class _HistoryRow extends StatelessWidget {
  final CallHistoryItem item;

  const _HistoryRow({required this.item});

  @override
  Widget build(BuildContext context) {
    final isMissed = item.missed;
    final directionIcon = item.direction == CallDirection.outgoing
        ? Icons.call_made_rounded
        : Icons.call_received_rounded;
    final typeIcon = item.type == CallType.video
        ? Icons.videocam_rounded
        : Icons.call_rounded;

    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => item.type == CallType.video
              ? VideoCallScreen(peer: item.user)
              : AudioCallScreen(peer: item.user),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: AppColors.primary.withValues(alpha: 0.12),
              child: Text(
                item.user.initials,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.user.name,
                    style: TextStyle(
                      fontSize: 15.5,
                      fontWeight: FontWeight.w600,
                      color: isMissed
                          ? AppColors.danger
                          : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Icon(
                        directionIcon,
                        size: 14,
                        color: isMissed
                            ? AppColors.danger
                            : AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Icon(typeIcon, size: 14, color: AppColors.textSecondary),
                      const SizedBox(width: 6),
                      Text(
                        formatCallTimestamp(item.time),
                        style: const TextStyle(
                          fontSize: 12.5,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              isMissed
                  ? 'Missed'
                  : formatDuration(item.duration ?? Duration.zero),
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isMissed ? AppColors.danger : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
