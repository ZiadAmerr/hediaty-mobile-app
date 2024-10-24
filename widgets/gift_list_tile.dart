// lib/pages/gift_list_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/event.dart';
import '../models/gift.dart';
import '../services/gift_service.dart';
import '../widgets/gift_list_tile.dart';
import 'add_edit_gift_page.dart';

class GiftListPage extends StatefulWidget {
  final Event event;

  const GiftListPage({Key? key, required this.event}) : super(key: key);

  @override
  _GiftListPageState createState() => _GiftListPageState();
}

class _GiftListPageState extends State<GiftListPage> {
  @override
  Widget build(BuildContext context) {
    final giftService = Provider.of<GiftService>(context);
    final giftList = giftService.getGiftListForEvent(widget.event.id);

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.event.name} Gifts'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              giftService.setSortCriteria(value);
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
      body: giftList.isEmpty
          ? Center(child: Text('No gifts found for this event.'))
          : ListView.builder(
              itemCount: giftList.length,
              itemBuilder: (context, index) {
                final gift = giftList[index];
                return GiftListTile(gift: gift);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to Add/Edit Gift Page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEditGiftPage(eventId: widget.event.id),
            ),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Add Gift',
      ),
    );
  }
}

