import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lumo/core/config/design_config.dart';
import '../../data/models/book.dart';
import '../widgets/banner_card.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/horizontal_book_list.dart';
import '../widgets/section_header.dart';
import 'book_detail_page.dart';
import 'discount_page.dart';
import 'new_arrival_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  List<Book> _filterBooksByCategory(List<Book> books, String categoryName) {
    final q = categoryName.toLowerCase();
    return books
        .where((book) => book.categories.any((c) => c.toLowerCase() == q))
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

          final books = snapshot.data!.docs
              .map(
                (d) =>
                    Book.fromFirestore(d.data()! as Map<String, dynamic>, d.id),
              )
              .toList(growable: false);

          final newArrivals = books
              .where((b) =>
          (b.discount == false) &&
              (b.discountPrice == 0))
              .toList();

          final discounted = books
              .where((b) => b.discount == true)
              .toList(growable: false);

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
                title: 'New Arrival',
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => NewArrivalPage()),
                    ),
              ),
              HorizontalBookList(
                books: newArrivals.take(4).toList(),
                onTap:
                    (b) => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BookDetailPage(book: b),
                      ),
                    ),
              ),

              // ── discount ──
              SectionHeader(
                title: 'Discount',
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => DiscountPage()),
                    ),
              ),
              HorizontalBookList(
                books: discounted.take(4).toList(),
                onTap:
                    (b) => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BookDetailPage(book: b),
                      ),
                    ),
              ),
            ],
          );
        },
      ),
    );
  }
}
