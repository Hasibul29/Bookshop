import 'package:flutter/material.dart';

BottomNavigationBar bottomNavigation({selectedIndex, onItemTapped}) {
  return BottomNavigationBar(
    currentIndex: selectedIndex,
    onTap: onItemTapped,
    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.book),
        label: "Book List",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.translate),
        label: "Words",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.bookmark),
        label: "Bookmark",
      ),
    ],
  );
}
