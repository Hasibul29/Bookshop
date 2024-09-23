import 'package:flutter/material.dart';

BottomNavigationBar bottomNavigation({selectedIndex, onItemTapped}) {
  return BottomNavigationBar(
    currentIndex: selectedIndex,
    onTap: onItemTapped,
    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.book),
        label: "Buy Book",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.book),
        label: "Buy Book",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.favorite),
        label: "Favorite",
      ),
    ],
  );
}
