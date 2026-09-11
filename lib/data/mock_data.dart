import '../models/call_model.dart';
import '../models/user_model.dart';

/// Static demo data.
class MockData {
  MockData._();

  static const currentUser = UserModel(
    id: 'me',
    name: 'Kushal',
    initials: 'ME',
    email: 'me@example.com',
    isOnline: true,
  );

  static const List<UserModel> contacts = [
    UserModel(
      id: '1',
      name: 'Sarita Shrestha',
      initials: 'SS',
      email: 'sarita.shrestha@example.com',
      isOnline: true,
    ),
    UserModel(
      id: '2',
      name: 'Jivan BK',
      initials: 'JB',
      email: 'jivan.bk@example.com',
      isOnline: false,
    ),
    UserModel(
      id: '3',
      name: 'Anish Bhattarai',
      initials: 'AB',
      email: 'anish.bhatta@example.com',
      isOnline: true,
    ),
    UserModel(
      id: '4',
      name: 'Priya Patel',
      initials: 'PP',
      email: 'priya.patel@example.com',
      isOnline: false,
    ),
    UserModel(
      id: '5',
      name: 'Manish RAi',
      initials: 'MR',
      email: 'manish.rai@example.com',
      isOnline: true,
    ),
  ];

  static List<CallHistoryItem> get callHistory {
    final now = DateTime.now();
    return [
      CallHistoryItem(
        user: contacts[0],
        type: CallType.video,
        direction: CallDirection.outgoing,
        time: now.subtract(const Duration(hours: 2)),
        duration: const Duration(minutes: 2, seconds: 35),
      ),
      CallHistoryItem(
        user: contacts[1],
        type: CallType.audio,
        direction: CallDirection.incoming,
        time: now.subtract(const Duration(days: 1, hours: 3)),
        missed: true,
      ),
      CallHistoryItem(
        user: contacts[2],
        type: CallType.audio,
        direction: CallDirection.incoming,
        time: now.subtract(const Duration(days: 1, hours: 6)),
        duration: const Duration(minutes: 8, seconds: 12),
      ),
      CallHistoryItem(
        user: contacts[4],
        type: CallType.video,
        direction: CallDirection.outgoing,
        time: now.subtract(const Duration(days: 2)),
        duration: const Duration(minutes: 0, seconds: 47),
      ),
      CallHistoryItem(
        user: contacts[3],
        type: CallType.video,
        direction: CallDirection.incoming,
        time: now.subtract(const Duration(days: 3)),
        missed: true,
      ),
    ];
  }
}
