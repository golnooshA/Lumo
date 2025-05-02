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
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = TextEditingController();
  String _query = '';

  // one snapshot for every book (cheapest dev-time option)
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
      backgroundColor: DesignConfig.backgroundColor,
      appBar: AppBar(
        backgroundColor: DesignConfig.appBarBackgroundColor,
        centerTitle: true,
        title: Text(
          'Search',
          style: TextStyle(
            color: DesignConfig.appBarTitleColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigation(currentIndex: 1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

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
              onChanged: (v) => setState(() => _query = v),
            ),
          ),

          // ── categories ──
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Categories',
                style: TextStyle(
                    fontSize: DesignConfig.headerSize,
                    fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 12),
          _buildCategories(),

          // ── results ──
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Results',
                style: TextStyle(
                    fontSize: DesignConfig.headerSize,
                    fontWeight: FontWeight.bold)),
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
        final cats =
        snapshot.data!.docs.map((d) => d['name'] as String).toList();

        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          scrollDirection: Axis.horizontal,
          itemCount: cats.length,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (_, i) {
            final c = cats[i];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CategoryPage(category: c),   // catName == "classic"
                  ),
                );
              },
              child: RoundButton(buttonText: c),
            );
          },
        );
      },
    ),
  );

  Widget _buildResults() => Expanded(
    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: _allBooks,
      builder: (context, snap) {
        if (!snap.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final q = _query.trim().toLowerCase();

        final books = snap.data!.docs.where((doc) {
          final data = doc.data();
          if (q.isEmpty) return true;

          final title = (data['title'] as String? ?? '').toLowerCase();
          if (title.contains(q)) return true;

          final cats = [
            ...((data['categories'] as List<dynamic>? ?? const [])
                .map((e) => e.toString())),
            if ((data['category'] as String?)?.isNotEmpty ?? false)
              data['category'] as String,
          ];
          return cats.any((c) => c.toLowerCase().contains(q));

        }).map((doc) => Book.fromFirestore(doc.data(), doc.id)).toList();

        if (books.isEmpty) {
          return const Center(child: Text('No books found'));
        }

        return GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: books.length,
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: .65,
            crossAxisSpacing: 12,
            mainAxisSpacing: 20,
          ),
          itemBuilder: (_, i) {
            final b = books[i];
            return BookCoverCard(
              bookCover: b.coverUrl,
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
    ),
  );
}
