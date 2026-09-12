import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../data/mock_data.dart';
import '../../models/user_model.dart';
import '../../widgets/user_tile.dart';
import '../call/audio_call_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  late List<UserModel> _filtered = MockData.contacts;

  void _onSearchChanged(String query) {
    setState(() {
      _filtered = MockData.contacts
          .where((u) => u.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _startAudioCall(UserModel user) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => AudioCallScreen(peer: user)));
  }

  void _startVideoCall(UserModel user) {
    // Navigator.of(
    //   context,
    // ).push(MaterialPageRoute(builder: (_) => VideoCallScreen(peer: user)));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      children: [
        //  To simulate one to preview that screen.
        Align(
          alignment: .topRight,
          child: IconButton(
            tooltip: 'Simulate incoming call',
            onPressed: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (_) => IncomingCallScreen(
              //       caller: MockData.contacts[0],
              //       type: CallType.video,
              //     ),
              //   ),
              // );
            },
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        ),

        const SizedBox(height: 22),
        TextField(
          controller: _searchController,
          onChanged: _onSearchChanged,
          decoration: const InputDecoration(
            hintText: 'Search people...',
            prefixIcon: Icon(Icons.search_rounded),
          ),
        ),
        const SizedBox(height: 24),

        const Text(
          'Contacts',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 4),
        if (_filtered.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Center(
              child: Text(
                'No contacts match your search.',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
          )
        else
          ..._filtered.map(
            (user) => UserTile(
              user: user,
              onAudioCall: () => _startAudioCall(user),
              onVideoCall: () => _startVideoCall(user),
            ),
          ),
      ],
    );
  }
}
