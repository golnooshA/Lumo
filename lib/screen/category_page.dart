import 'package:flutter/material.dart';
import 'package:lumo/widget/book_card.dart';
import 'package:lumo/widget/icon_text.dart';

import '../design/design_config.dart';

class CategoryPage extends StatelessWidget {

  final List<Map<String, String>> books = [
    {
      'title': 'Psyche and Eros',
      'author': 'Luna Mcnamara',
      'image': 'https://edit.org/images/cat/book-covers-big-2019101610.jpg',
      'price': '€11,19',
    },
    {
      'title': 'The Cleopatras',
      'author': 'Lloyd Llewellyn',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS36GaImhQXaqzdQkhgvQ1ZZtbru_p5-PsOaw&s',
      'price': '€24,60',
    },
    {
      'title': 'A History of the Roman Empire in 21 Women',
      'author': 'Emma Southon',
      'image': 'https://www.designforwriters.com/wp-content/uploads/2017/10/design-for-writers-book-cover-tf-2-a-million-to-one.jpg',
      'price': '€18,90',
    },
    {
      'title': 'The Greeks',
      'author': 'Roderick Beaton',
      'image': 'https://miblart.com/wp-content/uploads/2024/01/main-3-1-scaled.jpg',
      'price': '€21,50',
    },
    {
      'title': 'The Greeks',
      'author': 'Roderick Beaton',
      'image': 'https://miblart.com/wp-content/uploads/2024/01/main-3-1-scaled.jpg',
      'price': '€21,50',
    },
    {
      'title': 'The Greeks',
      'author': 'Roderick Beaton',
      'image': 'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/art-book-cover-design-template-34323b0f0734dccded21e0e3bebf004c_screen.jpg?ts=1637015198',
      'price': '€21,50',
    },
    {
      'title': 'The Greeks',
      'author': 'Roderick Beaton',
      'image': 'https://s26162.pcdn.co/wp-content/uploads/2020/01/Sin-Eater-by-Megan-Campisi.jpg',
      'price': '€21,50',
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: DesignConfig.appBarBackgroundColor,
          centerTitle: true,
          title: Text(
            'History',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter and Sort Row
            Row(
              children:  [
                IconText(text: 'Filter', icon: Icons.tune, onTap: (){}),
                SizedBox(width: 20),
                IconText(text: 'Sort', icon: Icons.sort, onTap: (){}),
              ],
            ),
            const SizedBox(height: 16),

            // Book Grid
            Expanded(
              child: GridView.builder(
                itemCount: books.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.5,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  final book = books[index];
                  return BookCard(title: book['title']!,
                      author: book['author']!,
                      cover: book['image']!,
                      price: book['price']!);
                },
              ),
            ),
          ],
        ),
      ),

    );
  }
}





