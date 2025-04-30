import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lumo/design/design_config.dart';
import 'package:lumo/screen/discount_page.dart';
import 'package:lumo/screen/new_arrival_page.dart';
import 'package:lumo/widget/banner_card.dart';
import 'package:lumo/widget/horizontal_book_list.dart';
import 'package:lumo/widget/section_header.dart';

import '../model/book.dart';
import '../widget/bottom_navigation.dart';
import 'book_detail_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});


  List<Book> _filterBooksByCategory(
      List<Book> books, String categoryName) {
    final q = categoryName.toLowerCase();
    return books
        .where((book) =>
        book.categories.any((c) => c.toLowerCase() == q))
        .toList();
  }

  // ⚡ fetch only books with discount = true
  final Stream<QuerySnapshot> _discountStream = FirebaseFirestore.instance
      .collection('books')
      .where('discount', isEqualTo: true)
      .snapshots();


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
      bottomNavigationBar: const BottomNavigation(currentIndex: 0),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('books').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No books available'));
          }

          // convert every Firestore doc → Book
          final books = snapshot.data!.docs
              .map((d) => Book.fromFirestore(
            d.data()! as Map<String, dynamic>,
            d.id,
          ))
              .toList(growable: false);

          // home-page sections
          final newArrivals = _filterBooksByCategory(books, 'new_arrival');
          // final bestSellers = _filterBooksByCategory(books, 'best_seller');

          return ListView(
            children: [
              // ── banner carousel ──
              Container(
                height: 200,
                width: double.infinity,
                color: DesignConfig.light_light_blue,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    BannerCard(image: 'assets/image/banner_one.png'),
                    BannerCard(image: 'assets/image/banner_two.png'),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ── new arrivals ──
              SectionHeader(
                title: 'New Arrivals',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => NewArrivalPage()),
                ),
              ),
              HorizontalBookList(
                books: newArrivals,                       // << changed
                onTap: (b) => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BookDetailPage(book: b),
                  ),
                ),
              ),

              // ── discount ──
              SectionHeader(
                title: 'Discount',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => DiscountPage()),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: _discountStream,
                builder: (context, snap) {
                  if (!snap.hasData) return const SizedBox(height: 120);

                  final discounted = snap.data!.docs
                      .map((d) => Book.fromFirestore(
                    d.data()! as Map<String, dynamic>,
                    d.id,
                  ))
                      .toList(growable: false);

                  return HorizontalBookList(
                    books: discounted,
                    onTap: (b) => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BookDetailPage(book: b),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
