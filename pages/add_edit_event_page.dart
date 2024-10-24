// lib/pages/add_edit_event_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/event.dart';
import '../services/event_service.dart';

class AddEditEventPage extends StatefulWidget {
  final Event? event;

  const AddEditEventPage({Key? key, this.event}) : super(key: key);

  @override
  _AddEditEventPageState createState() => _AddEditEventPageState();
}

class _AddEditEventPageState extends State<AddEditEventPage> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _category;
  late DateTime _date;
  late String _location;
  late String _description;
  late String _status;

  @override
  void initState() {
    super.initState();
    if (widget.event != null) {
      _name = widget.event!.name;
      _category = widget.event!.category;
      _date = widget.event!.date;
      _location = widget.event!.location;
      _description = widget.event!.description;
      _status = widget.event!.status;
    } else {
      _name = '';
      _category = '';
      _date = DateTime.now();
      _location = '';
      _description = '';
      _status = 'Upcoming';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.event != null;
    final eventService = Provider.of<EventService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Event' : 'Add Event'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Name
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Event Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter event name' : null,
                onSaved: (value) => _name = value!,
              ),
              // Category
              TextFormField(
                initialValue: _category,
                decoration: InputDecoration(labelText: 'Category'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter category' : null,
                onSaved: (value) => _category = value!,
              ),
              // Date
              ListTile(
                title: Text('Date: ${_date.toLocal()}'.split(' ')[0]),
                trailing: Icon(Icons.calendar_today),
                onTap: _pickDate,
              ),
              // Location
              TextFormField(
                initialValue: _location,
                decoration: InputDecoration(labelText: 'Location'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter location' : null,
                onSaved: (value) => _location = value!,
              ),
              // Description
              TextFormField(
                initialValue: _description,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                onSaved: (value) => _description = value!,
              ),
              // Status
              DropdownButtonFormField<String>(
                value: _status,
                items: ['Upcoming', 'Current', 'Past']
                    .map((label) => DropdownMenuItem(
                          child: Text(label),
                          value: label,
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _status = value!;
                  });
                },
                decoration: InputDecoration(labelText: 'Status'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _saveForm(eventService, isEditing);
                },
                child: Text(isEditing ? 'Update Event' : 'Add Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _date)
      setState(() {
        _date = picked;
      });
  }

  void _saveForm(EventService eventService, bool isEditing) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final event = Event(
        id: isEditing ? widget.event!.id : DateTime.now().toString(),
        name: _name,
        category: _category,
        date: _date,
        location: _location,
        description: _description,
        status: _status,
      );

      if (isEditing) {
        eventService.updateEvent(event);
      } else {
        eventService.addEvent(event);
      }

      Navigator.pop(context);
    }
  }
}

