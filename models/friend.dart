// lib/models/friend.dart

class Friend {
  final String id;
  final String name;
  final String profilePictureUrl;
  final int upcomingEventsCount;

  Friend({
    required this.id,
    required this.name,
    required this.profilePictureUrl,
    required this.upcomingEventsCount,
  });
}

