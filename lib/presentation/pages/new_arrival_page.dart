// lib/presentation/pages/new_arrival_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/config/design_config.dart';
import '../providers/book_provider.dart';
import '../widgets/book_card.dart';
import '../widgets/bottom_navigation.dart';
import 'book_detail_page.dart';

class NewArrivalPage extends ConsumerWidget {
  const NewArrivalPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final arrivals = ref.watch(newArrivalsProvider);

    return arrivals.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
      data: (books) {
        if (books.isEmpty) {
          return Scaffold(
            appBar: _buildAppBar(),
            bottomNavigationBar: const BottomNavigation(currentIndex: 0),
            body: const Center(child: Text('No new arrivals')),
          );
        }
        return Scaffold(
          appBar: _buildAppBar(),
          bottomNavigationBar: const BottomNavigation(currentIndex: 0),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: GridView.builder(
              itemCount: books.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.5,
                crossAxisSpacing: 8,
                mainAxisSpacing: 20,
              ),
              itemBuilder: (_, i) {
                final b = books[i];
                return BookCard(
                  title: b.title,
                  author: b.author,
                  cover: b.coverUrl,
                  price: b.price.toStringAsFixed(2),
                  discountPrice: '',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => BookDetailPage(book: b)),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  AppBar _buildAppBar() => AppBar(
    backgroundColor: DesignConfig.appBarBackgroundColor,
    centerTitle: true,
    title: Text(
      'New Arrival',
      style: TextStyle(
        color: DesignConfig.appBarTitleColor,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
