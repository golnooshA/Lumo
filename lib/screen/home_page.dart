import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lumo/design/design_config.dart';
import 'package:lumo/widget/banner_card.dart';
import 'package:lumo/widget/horizontal_book_list.dart';
import 'package:lumo/widget/section_header.dart';

import '../model/book.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Helper method to filter books by category
  List<Book> _filterBooksByCategory(List<Book> books, String category) {
    return books
        .where((book) => book.category.toLowerCase() == category.toLowerCase())
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DesignConfig.appBarBackgroundColor,
        title: Text(
          'Lumo',
          style: TextStyle(
            color: DesignConfig.appBarTitleColor,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: SizedBox(
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
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('books').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No books available'));
          }

          final books =
              snapshot.data!.docs.map((doc) {
                return Book.fromFirestore(
                  doc.data() as Map<String, dynamic>,
                  doc.id,
                );
              }).toList();

          final newArrivals = _filterBooksByCategory(books, 'new_arrival');
          final discountedBooks = _filterBooksByCategory(books, 'discount');
          final bestSellers = _filterBooksByCategory(books, 'best_seller');

          return ListView(
            children: [
              Container(
                color: DesignConfig.light_light_blue,
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    BannerCard(image: 'assets/image/banner_one.png'),
                    BannerCard(image: 'assets/image/banner_two.png'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SectionHeader(title: 'New Arrivals', onTap: () {}),
              HorizontalBookList(books: books, onTap: () {}),
              SectionHeader(title: 'Discount', onTap: () {}),
              HorizontalBookList(books: books, onTap: () {}),
              SectionHeader(title: 'Best Sellers', onTap: () {}),
              HorizontalBookList(books: books, onTap: () {}),
            ],
          );
        },
      ),
    );
  }
}
