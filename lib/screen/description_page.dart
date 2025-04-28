import 'package:flutter/material.dart';
import 'package:lumo/widget/book_card.dart';
import 'package:lumo/widget/icon_text.dart';

import '../design/design_config.dart';
import '../widget/discount_book_card.dart';

class DescriptionPage extends StatelessWidget {
  const DescriptionPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: DesignConfig.appBarBackgroundColor,
          centerTitle: true,
          title: Text(
            'Description',
            style: TextStyle(
              color: DesignConfig.appBarTitleColor,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: DesignConfig.appBarTitleFontSize,
            ),
          )),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: SizedBox(
              width: 24,
              height: 24,
              child: ImageIcon(AssetImage('assets/icon/home_light.png'),color: Colors.grey),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              width: 24,
              height: 24,
              child: ImageIcon(AssetImage('assets/icon/search_light.png'),color: Colors.grey),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              width: 24,
              height: 24,
              child: ImageIcon(AssetImage('assets/icon/bookmark_light.png'),color: Colors.grey),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              width: 24,
              height: 24,
              child: ImageIcon(AssetImage('assets/icon/discount_light.png'),color: Colors.grey),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              width: 24,
              height: 24,
              child: ImageIcon(AssetImage('assets/icon/user_light.png'),color: Colors.grey),
            ),
            label: '',
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Text(
          "A mind-bending, genre-blending, boy-that-ending mystery unlike any I’ve ever read’ A. J. FINN "
              "‘I loved it’ C. J. TUDOR ‘An absolute blast’ BENJAMIN ...",
          style: TextStyle(
            color: DesignConfig.textColor,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: DesignConfig.textSize,
          ),
        ) ),

    );
  }
}





