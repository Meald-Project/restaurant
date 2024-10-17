import 'package:flutter/material.dart';
import 'package:meald/views/pages/livreur_commande.dart';
import 'package:meald/views/pages/stats.dart';

import 'notification.dart';
import 'profile_resto.dart';

class TableauDebord extends StatefulWidget {
  const TableauDebord({Key? key}) : super(key: key);

  @override
  _TableauDebordState createState() => _TableauDebordState();
}

class _TableauDebordState extends State<TableauDebord> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    StatsPage(),
    LivreurCommandePage(),
    NotificationScreen(),
    ProfileResto(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.motorcycle),
            label: 'Livreur',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
