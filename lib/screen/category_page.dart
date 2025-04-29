import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lumo/widget/book_card.dart';
import 'package:lumo/widget/icon_text.dart';

import '../design/design_config.dart';
import '../widget/book_cover_card.dart';
import '../widget/bottom_navigation.dart';
import 'book_detail_page.dart';

class CategoryPage extends StatelessWidget {
  final String category;

  const CategoryPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DesignConfig.appBarBackgroundColor,
        centerTitle: true,
        title: Text(
          category,
          style: TextStyle(
            color: DesignConfig.appBarTitleColor,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: DesignConfig.appBarTitleFontSize,
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigation(currentIndex: 1),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream:
            FirebaseFirestore.instance
                .collection('books')
                .where('category', isEqualTo: category)
                .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snapshot.data!.docs;
          if (data.isEmpty) {
            return const Center(child: Text('No books in this category'));
          }
          return Padding(
            padding: const EdgeInsets.all(20),
            child: GridView.builder(
              itemCount: snapshot.data!.docs.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 12,
                mainAxisSpacing: 20,
              ),
              itemBuilder: (context, index) {
                final book = snapshot.data!.docs[index].data();
                return BookCard(
                  title: (book['title'] ?? '') as String,
                  author: (book['author'] ?? '') as String,
                  cover: (book['coverUrl'] ?? '') as String,
                  price: (book['price'] ?? '').toString(),
                  discountPrice: (book['discountPrice'] ?? '').toString(),
                  onTap: (){}
                );
              },
            ),
          );
        },
      ),
    );
  }
}
