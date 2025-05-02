import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore, QuerySnapshot;
import 'package:flutter/material.dart';
import 'package:lumo/widget/bookmark_card.dart';
import '../design/design_config.dart';
import '../model/book.dart';
import '../widget/bottom_navigation.dart';
import 'book_detail_page.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});


  Stream<QuerySnapshot> get bookStream =>
      FirebaseFirestore.instance.collection('books').snapshots();
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: DesignConfig.appBarBackgroundColor,
          centerTitle: true,
          title: Text(
            'Bookmark',
            style: TextStyle(
              color: DesignConfig.appBarTitleColor,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: DesignConfig.appBarTitleFontSize,
            ),
          )),
      bottomNavigationBar:  const BottomNavigation(currentIndex: 2),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

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
                      .map((d) => Book.fromFirestore(d.data()! as Map<String, dynamic>, d.id))
                      .where((book) => book.bookmark == true)
                      .toList();

                  return GridView.builder(
                    itemCount: books.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 20,
                    ),
                    itemBuilder: (_, i) => BookmarkCard(
                      cover: books[i].coverUrl,
                      bookmark: Icons.bookmark,
                      bookmarkTap: () async {
                        await FirebaseFirestore.instance
                            .collection('books')
                            .doc(books[i].id)
                            .update({'bookmark': false});
                      },
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





