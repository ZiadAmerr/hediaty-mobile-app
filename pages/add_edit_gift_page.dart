// lib/pages/add_edit_gift_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/gift.dart';
import '../services/gift_service.dart';

class AddEditGiftPage extends StatefulWidget {
  final Gift? gift;
  final String? eventId;

  const AddEditGiftPage({Key? key, this.gift, this.eventId}) : super(key: key);

  @override
  _AddEditGiftPageState createState() => _AddEditGiftPageState();
}

class _AddEditGiftPageState extends State<AddEditGiftPage> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _description;
  late String _category;
  late double _price;
  late String _status;

  @override
  void initState() {
    super.initState();
    if (widget.gift != null) {
      _name = widget.gift!.name;
      _description = widget.gift!.description;
      _category = widget.gift!.category;
      _price = widget.gift!.price;
      _status = widget.gift!.status;
    } else {
      _name = '';
      _description = '';
      _category = '';
      _price = 0.0;
      _status = 'Available';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.gift != null;
    final giftService = Provider.of<GiftService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Gift' : 'Add Gift'),
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
                decoration: InputDecoration(labelText: 'Gift Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter gift name' : null,
                onSaved: (value) => _name = value!,
              ),
              // Description
              TextFormField(
                initialValue: _description,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                onSaved: (value) => _description = value!,
              ),
              // Category
              TextFormField(
                initialValue: _category,
                decoration: InputDecoration(labelText: 'Category'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter category' : null,
                onSaved: (value) => _category = value!,
              ),
              // Price
              TextFormField(
                initialValue: _price != 0.0 ? _price.toString() : '',
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter price' : null,
                onSaved: (value) => _price = double.parse(value!),
              ),
              // Status
              DropdownButtonFormField<String>(
                value: _status,
                items: ['Available', 'Pledged', 'Purchased']
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
                  _saveForm(giftService, isEditing);
                },
                child: Text(isEditing ? 'Update Gift' : 'Add Gift'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveForm(GiftService giftService, bool isEditing) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final gift = Gift(
        id: isEditing ? widget.gift!.id : DateTime.now().toString(),
        name: _name,
        description: _description,
        category: _category,
        price: _price,
        status: _status,
        eventId: widget.gift?.eventId ?? widget.eventId!,
      );

      if (isEditing) {
        giftService.updateGift(gift);
      } else {
        giftService.addGift(gift);
      }

      Navigator.pop(context);
    }
  }
}

