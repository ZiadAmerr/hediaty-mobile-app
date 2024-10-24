// lib/pages/friend_gift_list_page.dart

import 'package:flutter/material.dart';
import '../models/friend.dart';

class FriendGiftListPage extends StatelessWidget {
  final Friend friend;

  const FriendGiftListPage({super.key, required this.friend});

  @override
  Widget build(BuildContext context) {
    // This page will display the friend's gift lists
    return Scaffold(
      appBar: AppBar(
        title: Text('${friend.name}\'s Gift Lists'),
      ),
      body: Center(
        child: Text('Gift lists for ${friend.name} will be displayed here.'),
      ),
    );
  }
}

