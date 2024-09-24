import 'package:flutter/material.dart';

import 'widgets/appbar.dart';
import '../booklist/booklist.dart';
import 'widgets/bottom_navigation.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(title: 'Demo'),
      bottomNavigationBar: bottomNavigation(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          const BookListView(),
          Container(
            color: Colors.green,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            color: Colors.blue,
            width: double.infinity,
            height: double.infinity,
          ),
        ],
      ),
    );
  }
}
