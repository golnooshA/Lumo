import 'package:flutter/material.dart';
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
      items: [
        BottomNavigationBarItem(
          activeIcon: HomePage(),
          icon: const SizedBox(
            width: 24,
            height: 24,
            child: ImageIcon(
              AssetImage('assets/icon/home_light.png'),
              color: Colors.grey,
            ),
          ),
          label: '',
        ),
         BottomNavigationBarItem(
           activeIcon: SearchPage(),
          icon: SizedBox(
            width: 24,
            height: 24,
            child: ImageIcon(
              AssetImage('assets/icon/search_light.png'),
              color: Colors.grey,
            ),
          ),
          label: '',
        ),
         BottomNavigationBarItem(
           // activeIcon: HomePage(),
          icon: SizedBox(
            width: 24,
            height: 24,
            child: ImageIcon(
              AssetImage('assets/icon/bookmark_light.png'),
              color: Colors.grey,
            ),
          ),
          label: '',
        ),
         BottomNavigationBarItem(
          activeIcon: DiscountPage(),
          icon: SizedBox(
            width: 24,
            height: 24,
            child: ImageIcon(
              AssetImage('assets/icon/discount_light.png'),
              color: Colors.grey,
            ),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          // activeIcon: AccountPage(),

          icon: SizedBox(
            width: 24,
            height: 24,
            child: ImageIcon(
              AssetImage('assets/icon/user_light.png'),
              color: Colors.grey,
            ),
          ),
          label: '',
        ),
      ],
    );
  }
}
