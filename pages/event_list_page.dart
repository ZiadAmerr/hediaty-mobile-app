// lib/pages/event_list_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/event.dart';
import '../services/event_service.dart';
import '../widgets/event_list_tile.dart';
import 'add_edit_event_page.dart';

class EventListPage extends StatefulWidget {
  @override
  _EventListPageState createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {
  @override
  Widget build(BuildContext context) {
    final eventService = Provider.of<EventService>(context);
    final eventList = eventService.eventList;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Events'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              eventService.setSortCriteria(value);
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(value: 'name', child: Text('Sort by Name')),
                PopupMenuItem(value: 'category', child: Text('Sort by Category')),
                PopupMenuItem(value: 'status', child: Text('Sort by Status')),
              ];
            },
            icon: Icon(Icons.sort),
          ),
        ],
      ),
      body: eventList.isEmpty
          ? Center(child: Text('No events found.'))
          : ListView.builder(
              itemCount: eventList.length,
              itemBuilder: (context, index) {
                final event = eventList[index];
                return EventListTile(event: event);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to Add/Edit Event Page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEditEventPage(),
            ),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Add Event',
      ),
    );
  }
}

