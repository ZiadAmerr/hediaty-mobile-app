// lib/pages/add_friend_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/friend.dart';
import '../services/friend_service.dart';

class AddFriendPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _profilePictureUrlController = TextEditingController();

  AddFriendPage({super.key});
  // Implement controllers for phone number or contact selection if needed

  @override
  Widget build(BuildContext context) {
    final friendService = Provider.of<FriendService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Friend'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Friend\'s Name',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _profilePictureUrlController,
              decoration: const InputDecoration(
                labelText: 'Profile Picture URL',
              ),
            ),
            // Add fields or buttons for phone number/contact selection
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                // Validate inputs
                if (_nameController.text.isEmpty) {
                  // Show error
                  return;
                }

                final newFriend = Friend(
                  id: DateTime.now().toString(),
                  name: _nameController.text,
                  profilePictureUrl: _profilePictureUrlController.text,
                  upcomingEventsCount: 0,
                );

                friendService.addFriend(newFriend);
                Navigator.pop(context);
              },
              child: const Text('Add Friend'),
            ),
          ],
        ),
      ),
    );
  }
}

