// lib/models/event.dart

class Event {
  final String id;
  final String name;
  final String category;
  final DateTime date;
  final String location;
  final String description;
  final String status; // 'Upcoming', 'Current', 'Past'

  Event({
    required this.id,
    required this.name,
    required this.category,
    required this.date,
    required this.location,
    required this.description,
    required this.status,
  });
}

