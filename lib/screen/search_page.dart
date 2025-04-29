import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../design/design_config.dart';
import '../widget/bottom_navigation.dart';
import '../component/round_button.dart';
import '../model/book.dart';
import '../widget/book_cover_card.dart';
import 'book_detail_page.dart';
import 'category_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  String _query = '';

  /// Single stream with every book (ordered once, filtered client-side).
  late final Stream<QuerySnapshot<Map<String, dynamic>>> _allBooks =
  FirebaseFirestore.instance
      .collection('books')
      .orderBy('title')
      .snapshots();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DesignConfig.appBarBackgroundColor,
        title: const Text('Search'),
      ),
      bottomNavigationBar: const BottomNavigation(currentIndex: 1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── search field
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search books …',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
              onChanged: (value) => setState(() => _query = value),
            ),
          ),

          // ── categories
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Categories',
              style: TextStyle(
                fontSize: DesignConfig.headerSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 6),
          _buildCategories(),

          // ── results
          const SizedBox(height: 18),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Results',
              style: TextStyle(
                fontSize: DesignConfig.headerSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),
          _buildResults(),
        ],
      ),
    );
  }


  Widget _buildCategories() => SizedBox(
    height: 40,
    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('categories')
          .orderBy('name')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox();

        final categories = snapshot.data!.docs
            .map((doc) => doc['name'] as String)
            .toList(growable: false);

        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            final category = categories[index];
            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CategoryPage(category: category),
                ),
              ),
              child: RoundButton(buttonText: category),
            );
          },
        );
      },
    ),
  );

  Widget _buildResults() => Expanded(
    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: _allBooks,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final q = _query.trim().toLowerCase();
        final books = snapshot.data!.docs
            .where((doc) {
          if (q.isEmpty) return true; // show everything
          final title = (doc['title'] as String).toLowerCase();
          return title.contains(q);
        })
            .map((doc) => Book.fromFirestore(doc.data(), doc.id))
            .toList(growable: false);

        if (books.isEmpty) {
          return const Center(child: Text('No books found'));
        }

        return GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: books.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: .65,
            crossAxisSpacing: 12,
            mainAxisSpacing: 20,
          ),
          itemBuilder: (context, index) {
            final book = books[index];
            return BookCoverCard(
              bookCover: book.coverUrl,
              onTap: () => Navigator.push(
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
  );
}
