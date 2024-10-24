// lib/widgets/friend_list_tile.dart

import 'package:flutter/material.dart';
import '../models/friend.dart';
import '../pages/friend_gift_list_page.dart';

class FriendListTile extends StatelessWidget {
  final Friend friend;

  const FriendListTile({Key? key, required this.friend}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(friend.profilePictureUrl),
        backgroundColor: Colors.grey[200],
      ),
      title: Text(friend.name),
      subtitle: Text('Upcoming Events: ${friend.upcomingEventsCount}'),
      trailing: Icon(Icons.chevron_right),
      onTap: () {
        // Navigate to Friend's Gift Lists Page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FriendGiftListPage(friend: friend),
          ),
        );
      },
    );
  }
}

