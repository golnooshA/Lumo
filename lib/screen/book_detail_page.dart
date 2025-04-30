import 'package:flutter/material.dart';
import 'package:lumo/screen/details_page.dart';
import 'package:lumo/widget/add_to_cart_button.dart';
import '../design/design_config.dart';
import '../model/book.dart';
import '../widget/bottom_navigation.dart';
import '../widget/details_row.dart';
import 'description_page.dart';

class BookDetailPage extends StatelessWidget {
  final Book book;

  const BookDetailPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: DesignConfig.appBarBackgroundColor,
        elevation: 0,
      ),
      bottomNavigationBar: const BottomNavigation(currentIndex: 1),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            // ── cover ──
            Center(
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(book.coverUrl, height: 220),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ── title ──
            Text(
              book.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            // ── rating & icons ──
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                  5,
                      (i) =>
                      Icon(
                        i < book.rating.round() ? Icons.star : Icons
                            .star_border,
                        color: Colors.amber,
                        size: 20,
                      ),
                ),
                const SizedBox(width: 8),
                Text(
                  book.rating.toString(),
                  style: const TextStyle(color: Colors.grey),
                ),
                const Spacer(),
                const Icon(Icons.favorite_border),
                const SizedBox(width: 16),
                const Icon(Icons.share),
              ],
            ),

            const SizedBox(height: 20),

            // ── add to cart ──
            CartADButton(
              title: 'Add to cart',
              price: book.price.toString(),
              discountPrice: book.discountPrice.toString(),
              cardColor: DesignConfig.addCart,
            ),

            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Description',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: DesignConfig.textSize,
                  ),
                ),
                InkWell(
                  onTap:
                      () =>
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) =>
                              DescriptionPage(
                                description: book.description,
                              ),
                        ),
                      ),
                  child: const Text(
                    'more >',
                    style: TextStyle(color: Colors.orange),
                  ),
                ),
              ],
            ),

            const Divider(height: 20),

            // const SizedBox(height: 8),
            Text(
              book.description,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Details',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: DesignConfig.textSize,
                  ),
                ),
                InkWell(
                  onTap: () =>
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailsPage(book: book),
                        ),
                      ),
                  child: const Text('more >',
                      style: TextStyle(color: Colors.orange)),
                ),
              ],
            ),

            const Divider(height: 20),

            DetailsRow(title: 'Author', value: book.author),
            DetailsRow(
              title: 'Categories',
              value:
              book.categories.isNotEmpty ? book.categories.join(', ') : '—',
            ),
            DetailsRow(title: 'Pages', value: book.pages.toString()),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
