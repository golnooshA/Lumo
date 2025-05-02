import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lumo/design/design_config.dart';
import 'package:lumo/model/book.dart';
import 'package:lumo/widget/book_card.dart';
import 'package:lumo/widget/bottom_navigation.dart';
import '../widget/icon_text.dart';
import 'book_detail_page.dart';

class CategoryPage extends StatelessWidget {
  final String category;
  const CategoryPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {

    final bookStream = FirebaseFirestore.instance
        .collection('books')
        .where('category',arrayContains: category.trim())
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: DesignConfig.appBarBackgroundColor,
        centerTitle: true,
        title: Text(
          category,
          style: TextStyle(
            color: DesignConfig.appBarTitleColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigation(currentIndex: 1),
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
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: bookStream,
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snap.hasData || snap.data!.docs.isEmpty) {
                    return const Center(child: Text('No books yet'));
                  }

                  final books = snap.data!.docs
                      .map((d) => Book.fromFirestore(d.data(), d.id))
                      .toList(growable: false)
                    ..sort((a, b) => a.title.compareTo(b.title));

                  return GridView.builder(
                    itemCount: books.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.5,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 20,
                    ),
                    itemBuilder: (_, i) {
                      final b = books[i];
                      final dp = b.discountPrice;

                      return BookCard(
                        title: b.title,
                        author: b.author,
                        cover: b.coverUrl,
                        price: b.price.toStringAsFixed(2),
                        discountPrice: dp == 0 ? '' : dp.toStringAsFixed(2),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BookDetailPage(book: b),
                          ),
                        ),
                      );
                    },
                  );
                },
              )
            ),
          ],
        ),
      ),




    );
  }
}
