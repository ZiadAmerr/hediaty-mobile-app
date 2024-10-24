// lib/pages/home_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/friend_service.dart';
import '../widgets/friend_list_tile.dart';
import 'add_friend_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final friendService = Provider.of<FriendService>(context);
    final friendsList = friendService.friendsList.where((friend) {
      return friend.name.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hedieaty'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () {
              // Navigate to Add Friends Page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddFriendPage()),
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Friends',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
        ),
      ),
      body: friendsList.isEmpty
          ? const Center(child: Text('No friends found.'))
          : ListView.builder(
              itemCount: friendsList.length,
              itemBuilder: (context, index) {
                final friend = friendsList[index];
                return FriendListTile(friend: friend);
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigate to Create Event/List Page
        },
        label: const Text('Create Your Own Event/List'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}

