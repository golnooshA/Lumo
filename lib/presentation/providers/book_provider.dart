import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/book_repository.dart';
import '../../data/models/book.dart';

final bookRepoProvider = Provider<BookRepository>((ref) => BookRepository());

final allBooksProvider = StreamProvider<List<Book>>((ref) =>
    ref.watch(bookRepoProvider).watchAll());

final newArrivalsProvider = StreamProvider<List<Book>>((ref) =>
    ref.watch(bookRepoProvider).watchNewArrivals());

final discountedProvider = StreamProvider<List<Book>>((ref) =>
    ref.watch(bookRepoProvider).watchDiscounted());

final categoryBooksProvider = StreamProvider.family<List<Book>, String>((ref, category) =>
    ref.watch(bookRepoProvider).watchByCategory(category));

final bookmarkedBooksProvider = StreamProvider<List<Book>>((ref) =>
    ref.watch(bookRepoProvider).watchBookmarked());

final cartBooksProvider = StreamProvider<List<Book>>((ref) =>
    ref.watch(bookRepoProvider).watchInCart());

final purchasedBooksProvider = StreamProvider<List<Book>>((ref) =>
    ref.watch(bookRepoProvider).watchPurchased());
