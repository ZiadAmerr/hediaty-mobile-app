// lib/services/friend_service.dart

import 'package:flutter/material.dart';
import '../models/friend.dart';

class FriendService with ChangeNotifier {
  final List<Friend> _friendsList = [
    // Sample data
    Friend(
      id: '1',
      name: 'Alice Smith',
      profilePictureUrl: 'https://example.com/alice.jpg',
      upcomingEventsCount: 2,
    ),
    Friend(
      id: '2',
      name: 'Bob Johnson',
      profilePictureUrl: 'https://example.com/bob.jpg',
      upcomingEventsCount: 1,
    ),
    // Add more friends as needed
  ];

  List<Friend> get friendsList => _friendsList;

  void addFriend(Friend friend) {
    _friendsList.add(friend);
    notifyListeners();
  }

  // Implement search, remove, update functions as needed
}

