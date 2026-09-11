import 'user_model.dart';

enum CallType { audio, video }

enum CallDirection { incoming, outgoing }

class CallHistoryItem {
  final UserModel user;
  final CallType type;
  final CallDirection direction;
  final DateTime time;
  final Duration? duration; // null when the call was missed
  final bool missed;

  const CallHistoryItem({
    required this.user,
    required this.type,
    required this.direction,
    required this.time,
    this.duration,
    this.missed = false,
  });
}
