import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/category_repository.dart';
import '../../data/models/category.dart';

final categoryRepoProvider =
Provider<CategoryRepository>((ref) => CategoryRepository());

/// Stream of all categories for the horizontal list in SearchPage
final categoriesProvider = StreamProvider<List<Category>>((ref) =>
    ref.watch(categoryRepoProvider).watchAll());
