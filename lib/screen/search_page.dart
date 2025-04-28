// SearchPage with a search bar and horizontal categories
import 'package:flutter/material.dart';
import 'package:lumo/component/round_button.dart';
import 'package:lumo/widget/book_cover_card.dart';
import 'package:lumo/widget/textfield_icon.dart';

import '../design/design_config.dart';

class SearchPage extends StatelessWidget {
  final List<String> categories = [
    'Ancient',
    'Romance',
    'Sci-Fi',
    'Mystery',
    'History',
    'Philosophy',
    'Ancient',
    'Romance',
    'Sci-Fi',
    'Mystery',
    'History',
    'Philosophy',
    'Ancient',
    'Romance',
    'Sci-Fi',
    'Mystery',
    'History',
    'Philosophy',
  ];

  final List<Map<String, String>> searchResults = [
    {'image': 'https://edit.org/images/cat/book-covers-big-2019101610.jpg'},
    {'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS36GaImhQXaqzdQkhgvQ1ZZtbru_p5-PsOaw&s'},
    {'image': 'https://www.designforwriters.com/wp-content/uploads/2017/10/design-for-writers-book-cover-tf-2-a-million-to-one.jpg'},
    {'image': 'https://edit.org/images/cat/book-covers-big-2019101610.jpg'},
    {'image': 'https://edit.org/images/cat/book-covers-big-2019101610.jpg'},

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DesignConfig.appBarBackgroundColor,
        title: Text(
          'Search',
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


      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFieldIcon(icon: Icons.search, hintText: 'Search Books ...'),
          ),
          const SizedBox(height: 20),

          // Categories
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 8),
            child: const Text('Categories', style: TextStyle(fontSize: DesignConfig.headerSize, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return RoundButton(buttonText: categories[index]);
              },
            ),
          ),

          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 8),
            child: const Text('Results', style: TextStyle(fontSize: DesignConfig.headerSize, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 12),

          // Search Results
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: GridView.builder(
                itemCount: searchResults.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  final book = searchResults[index];
                  return BookCoverCard(bookCover: book['image']!, onTap: (){});
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
