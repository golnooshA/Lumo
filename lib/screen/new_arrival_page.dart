import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore, QuerySnapshot;
import 'package:flutter/material.dart';
import 'package:lumo/widget/book_card.dart';
import 'package:lumo/widget/icon_text.dart';

import '../design/design_config.dart';
import '../model/book.dart';
import '../widget/bottom_navigation.dart';
import 'book_detail_page.dart';

class NewArrivalPage extends StatelessWidget {
  const NewArrivalPage({super.key});


  Stream<QuerySnapshot> get bookStream =>
      FirebaseFirestore.instance.collection('books').snapshots();
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: DesignConfig.appBarBackgroundColor,
          centerTitle: true,
          title: Text(
            'New Arrival',
            style: TextStyle(
              color: DesignConfig.appBarTitleColor,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: DesignConfig.appBarTitleFontSize,
            ),
          )),
      bottomNavigationBar:  const BottomNavigation(currentIndex: 0),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children:  [
                IconText(text: 'Filter', icon: Icons.tune, onTap: (){}),
                SizedBox(width: 20),
                IconText(text: 'Sort', icon: Icons.sort, onTap: (){}),
              ],
            ),
            const SizedBox(height: 16),

            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: bookStream,
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snap.hasData || snap.data!.docs.isEmpty) {
                    return const Center(child: Text('No books yet'));
                  }

                  final books = snap.data!.docs
                      .map((d) => Book.fromFirestore(
                      d.data()! as Map<String, dynamic>, d.id))
                      .where((book) =>
                  (book.discount == false) &&
                      (book.discountPrice == 0))
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
                    itemBuilder: (_, i) => BookCard(
                      title: books[i].title,
                      author: books[i].author,
                      cover: books[i].coverUrl,
                      price: books[i].price.toStringAsFixed(2),
                      discountPrice: '',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BookDetailPage(book: books[i]),
                        ),
                      ),
                    ),
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





