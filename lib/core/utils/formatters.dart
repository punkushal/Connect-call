String formatDuration(Duration d) {
  final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
  final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
  return '$minutes:$seconds';
}

/// Small, dependency-free formatting helpers so the UI doesn't need
/// the `intl` package just to show "Today, 11:45 AM".
String formatCallTimestamp(DateTime time) {
  final now = DateTime.now();
  final isToday =
      now.year == time.year && now.month == time.month && now.day == time.day;

  final yesterday = now.subtract(const Duration(days: 1));
  final isYesterday =
      yesterday.year == time.year &&
      yesterday.month == time.month &&
      yesterday.day == time.day;

  final hour12 = time.hour % 12 == 0 ? 12 : time.hour % 12;
  final minute = time.minute.toString().padLeft(2, '0');
  final period = time.hour >= 12 ? 'PM' : 'AM';
  final clock = '$hour12:$minute $period';

  if (isToday) return 'Today, $clock';
  if (isYesterday) return 'Yesterday, $clock';
  return '${time.month}/${time.day}/${time.year}, $clock';
}
