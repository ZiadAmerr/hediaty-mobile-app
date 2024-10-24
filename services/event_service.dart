// lib/services/event_service.dart

import 'package:flutter/material.dart';
import '../models/event.dart';

class EventService with ChangeNotifier {
  List<Event> _eventList = [
    // Sample data
    Event(
      id: '1',
      name: 'Birthday Party',
      category: 'Birthday',
      date: DateTime.now().add(Duration(days: 10)),
      location: 'My House',
      description: 'A fun birthday party!',
      status: 'Upcoming',
    ),
    // Add more events as needed
  ];

  String _sortCriteria = 'name'; // 'name', 'category', 'status'

  List<Event> get eventList {
    List<Event> sortedList = [..._eventList];
    sortedList.sort((a, b) {
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
    return sortedList;
  }

  void addEvent(Event event) {
    _eventList.add(event);
    notifyListeners();
  }

  void updateEvent(Event event) {
    int index = _eventList.indexWhere((e) => e.id == event.id);
    if (index != -1) {
      _eventList[index] = event;
      notifyListeners();
    }
  }

  void deleteEvent(String id) {
    _eventList.removeWhere((event) => event.id == id);
    notifyListeners();
  }

  void setSortCriteria(String criteria) {
    _sortCriteria = criteria;
    notifyListeners();
  }

  // Additional methods as needed
}

