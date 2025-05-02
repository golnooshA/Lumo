import 'package:flutter/material.dart';
import 'package:lumo/screen/bookmark_page.dart';
import 'package:lumo/screen/discount_page.dart';
import 'package:lumo/screen/search_page.dart';

import '../screen/home_page.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex;

  const BottomNavigation({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        if (index == currentIndex) return;

        switch (index) {
          case 0:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => HomePage()),
            );
            break;
          case 1:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => SearchPage()),
            );
            break;
          case 2:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => BookmarkPage()),
            );
            break;
          case 3:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => DiscountPage()),
            );
            break;
        // Add cases for others if needed
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: ImageIcon(
            const AssetImage('assets/icon/home_light.png'),
            color: currentIndex == 0 ? Colors.blue : Colors.grey,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            const AssetImage('assets/icon/search_light.png'),
            color: currentIndex == 1 ? Colors.blue : Colors.grey,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            const AssetImage('assets/icon/bookmark_light.png'),
            color: currentIndex == 2 ? Colors.blue : Colors.grey,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            const AssetImage('assets/icon/discount_light.png'),
            color: currentIndex == 3 ? Colors.blue : Colors.grey,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            const AssetImage('assets/icon/user_light.png'),
            color: currentIndex == 4 ? Colors.blue : Colors.grey,
          ),
          label: '',
        ),
      ],
    );
  }
}
