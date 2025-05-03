import 'package:flutter/material.dart';
import 'package:lumo/core/config/design_config.dart';
import 'package:lumo/presentation/pages/cart_page.dart';
import 'package:lumo/presentation/pages/search_page.dart';

import '../pages/account_page.dart';
import '../pages/bookmark_page.dart';
import '../pages/home_page.dart';

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
              MaterialPageRoute(builder: (_) => CartPage()),
            );
            break;
          case 4:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => AccountPage()),
            );
            break;
          // Add cases for others if needed
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: ImageIcon(
            const AssetImage('assets/icon/home_light.png'),
            color:
                currentIndex == 0
                    ? DesignConfig.bottomNavigationSelected
                    : Colors.grey,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            const AssetImage('assets/icon/search_light.png'),
            color:
                currentIndex == 1
                    ? DesignConfig.bottomNavigationSelected
                    : Colors.grey,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            const AssetImage('assets/icon/bookmark_light.png'),
            color:
                currentIndex == 2
                    ? DesignConfig.bottomNavigationSelected
                    : Colors.grey,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            const AssetImage('assets/icon/cart_light.png'),
            color:
                currentIndex == 3
                    ? DesignConfig.bottomNavigationSelected
                    : Colors.grey,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            const AssetImage('assets/icon/user_light.png'),
            color:
                currentIndex == 4
                    ? DesignConfig.bottomNavigationSelected
                    : Colors.grey,
          ),
          label: '',
        ),
      ],
    );
  }
}
