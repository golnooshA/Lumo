

import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex;
  const BottomNavigation({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      items: const [
        BottomNavigationBarItem(icon: SizedBox(width: 24, height: 24, child: ImageIcon(AssetImage('assets/icon/home_light.png'), color: Colors.grey)), label: ''),
        BottomNavigationBarItem(icon: SizedBox(width: 24, height: 24, child: ImageIcon(AssetImage('assets/icon/search_light.png'), color: Colors.grey)), label: ''),
        BottomNavigationBarItem(icon: SizedBox(width: 24, height: 24, child: ImageIcon(AssetImage('assets/icon/bookmark_light.png'), color: Colors.grey)), label: ''),
        BottomNavigationBarItem(icon: SizedBox(width: 24, height: 24, child: ImageIcon(AssetImage('assets/icon/discount_light.png'), color: Colors.grey)), label: ''),
        BottomNavigationBarItem(icon: SizedBox(width: 24, height: 24, child: ImageIcon(AssetImage('assets/icon/user_light.png'), color: Colors.grey)), label: ''),
      ],
    );
  }
}