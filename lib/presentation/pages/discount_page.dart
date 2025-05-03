import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../core/config/design_config.dart';
import '../../data/models/book.dart';
import '../widgets/book_card.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/icon_text.dart';
import 'book_detail_page.dart';

class DiscountPage extends StatelessWidget {
  final Stream<QuerySnapshot> discountStream =
      FirebaseFirestore.instance
          .collection('books')
          .where('discountPrice', isGreaterThan: 0)
          .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DesignConfig.appBarBackgroundColor,
        centerTitle: true,
        title: Text(
          'Discount',
          style: TextStyle(
            color: DesignConfig.appBarTitleColor,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: DesignConfig.appBarTitleFontSize,
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigation(currentIndex: 0),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter and Sort Row
            Row(
              children: [
                IconText(text: 'Filter', icon: Icons.tune, onTap: () {}),
                SizedBox(width: 20),
                IconText(text: 'Sort', icon: Icons.sort, onTap: () {}),
              ],
            ),
            const SizedBox(height: 16),

            // Book Grid
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: discountStream,
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snap.hasData || snap.data!.docs.isEmpty) {
                    return const Center(child: Text('No books yet'));
                  }

                  final books =
                      snap.data!.docs
                          .map(
                            (d) => Book.fromFirestore(
                              d.data()! as Map<String, dynamic>,
                              d.id,
                            ),
                          )
                          .toList();

                  return GridView.builder(
                    itemCount: books.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.5,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 20,
                        ),
                    itemBuilder: (_, i) {
                      final book = books[i];
                      final dp = book.discountPrice;

                      return BookCard(
                        title: book.title,
                        author: book.author,
                        cover: book.coverUrl,
                        price: book.price.toStringAsFixed(2),
                        discountPrice:
                            dp == 0
                                ? '' //  ← no badge
                                : dp.toStringAsFixed(2),
                        onTap:
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BookDetailPage(book: book),
                              ),
                            ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
