// lib/services/gift_service.dart

import 'package:flutter/material.dart';
import '../models/gift.dart';

class GiftService with ChangeNotifier {
  List<Gift> _giftList = [
    // Sample data
    Gift(
      id: '1',
      name: 'Watch',
      description: 'A fancy wristwatch.',
      category: 'Accessories',
      price: 199.99,
      status: 'Available',
      eventId: '1', // Assuming event with id '1' exists
    ),
    // Add more gifts as needed
  ];

  String _sortCriteria = 'name'; // 'name', 'category', 'status'

  List<Gift> getGiftListForEvent(String eventId) {
    List<Gift> gifts = _giftList.where((gift) => gift.eventId == eventId).toList();
    gifts.sort((a, b) {
      switch (_sortCriteria) {
        case 'name':
          return a.name.compareTo(b.name);
        case 'category':
          return a.category.compareTo(b.category);
        case 'status':
          return a.status.compareTo(b.status);
        default:
          return 0;
      }
    });
    return gifts;
  }

  void addGift(Gift gift) {
    _giftList.add(gift);
    notifyListeners();
  }

  void updateGift(Gift gift) {
    int index = _giftList.indexWhere((g) => g.id == gift.id);
    if (index != -1) {
      _giftList[index] = gift;
      notifyListeners();
    }
  }

  void deleteGift(String id) {
    _giftList.removeWhere((gift) => gift.id == id);
    notifyListeners();
  }

  void setSortCriteria(String criteria) {
    _sortCriteria = criteria;
    notifyListeners();
  }
}

