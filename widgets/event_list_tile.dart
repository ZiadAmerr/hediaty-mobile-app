// lib/widgets/event_list_tile.dart

import 'package:flutter/material.dart';
import 'package:hediaty/services/event_service.dart';
import 'package:provider/provider.dart';
import '../models/event.dart';
import '../pages/gift_list_page.dart';
import '../pages/add_edit_event_page.dart';
import 'package:intl/intl.dart';

class EventListTile extends StatelessWidget {
  final Event event;

  const EventListTile({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine color based on event status
    Color statusColor;
    switch (event.status) {
      case 'Upcoming':
        statusColor = Colors.green;
        break;
      case 'Current':
        statusColor = Colors.blue;
        break;
      case 'Past':
        statusColor = Colors.grey;
        break;
      default:
        statusColor = Colors.black;
    }

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: statusColor,
          child: Icon(Icons.event, color: Colors.white),
        ),
        title: Text(event.name),
        subtitle: Text(
          '${event.category} • ${DateFormat.yMMMd().format(event.date)}',
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'edit') {
              // Navigate to Edit Event Page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditEventPage(event: event),
                ),
              );
            } else if (value == 'delete') {
              // Delete the event
              _confirmDelete(context, event.id);
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(value: 'edit', child: Text('Edit')),
              PopupMenuItem(value: 'delete', child: Text('Delete')),
            ];
          },
        ),
        onTap: () {
          // Navigate to Gift List Page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GiftListPage(event: event),
            ),
          );
        },
      ),
    );
  }

  void _confirmDelete(BuildContext context, String eventId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Delete Event'),
        content: Text('Are you sure you want to delete this event?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Delete event
              Provider.of<EventService>(context, listen: false)
                  .deleteEvent(eventId);
              Navigator.of(ctx).pop();
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }
}

