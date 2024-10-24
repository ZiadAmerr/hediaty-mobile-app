// lib/services/friend_service.dart

import 'package:flutter/material.dart';
import '../models/friend.dart';

class FriendService with ChangeNotifier {
  final List<Friend> _friendsList = [
    // Sample data
    Friend(
      id: '1',
      name: 'Ziad Amerr',
      profilePictureUrl: 'https://scontent.fcai21-3.fna.fbcdn.net/v/t39.30808-1/458470389_2256772061349358_3053336235380018413_n.jpg?stp=dst-jpg_s320x320&_nc_cat=100&ccb=1-7&_nc_sid=0ecb9b&_nc_ohc=lJk1Iqx_6ckQ7kNvgFc1bz-&_nc_ht=scontent.fcai21-3.fna&_nc_gid=AmX5PSdr5aaL4rOLSxQQf7Q&oh=00_AYCi8QgYFAjlnB7BJ9A7AXDBw4q4lcGlnqBpuSqGLmRAUg&oe=67202865',
      upcomingEventsCount: 2,
    ),
    Friend(
      id: '2',
      name: 'Obai Amerr',
      profilePictureUrl: 'https://scontent.fcai21-3.fna.fbcdn.net/v/t39.30808-6/459989616_2649312781914696_5532479413320561472_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=e13IylqrihgQ7kNvgGxYDgB&_nc_ht=scontent.fcai21-3.fna&_nc_gid=A5XC0V97JnC-gvpFp29KKtL&oh=00_AYCVVoe5PhcaiuGDkLfGwsHSW_p4qLU3y9szHZXrNmN5FA&oe=67201A62',
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

