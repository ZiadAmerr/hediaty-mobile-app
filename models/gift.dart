// lib/models/gift.dart

class Gift {
  final String id;
  final String name;
  final String description;
  final String category;
  final double price;
  final String status; // 'Available', 'Pledged', 'Purchased'
  final String eventId; // Reference to the associated event

  Gift({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    required this.status,
    required this.eventId,
  });
}

