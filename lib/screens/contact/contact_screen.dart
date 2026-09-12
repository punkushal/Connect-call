import 'package:flutter/material.dart';
import '../../data/mock_data.dart';
import '../../models/user_model.dart';
import '../../widgets/user_tile.dart';
import '../call/audio_call_screen.dart';
import '../call/video_call_screen.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  late List<UserModel> _filtered = MockData.contacts;

  void _onSearchChanged(String query) {
    setState(() {
      _filtered = MockData.contacts
          .where((u) => u.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contacts'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 24),
        children: [
          TextField(
            onChanged: _onSearchChanged,
            decoration: const InputDecoration(
              hintText: 'Search people...',
              prefixIcon: Icon(Icons.search_rounded),
            ),
          ),
          const SizedBox(height: 12),
          if (_filtered.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Center(child: Text('No contacts found.')),
            )
          else
            ..._filtered.map(
              (user) => UserTile(
                user: user,
                onAudioCall: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => AudioCallScreen(peer: user),
                  ),
                ),
                onVideoCall: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => VideoCallScreen(peer: user),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
