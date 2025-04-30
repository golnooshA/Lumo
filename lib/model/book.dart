import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  final String id;
  final String title;
  final String author;
  final String coverUrl;
  final String description;
  final int pages;
  final DateTime publishDate;
  final String publisher;
  final double rating;
  final String fileUrl;
  final bool discount;
  final bool cart;
  final bool bookmark;
  final double price;
  final double discountPrice;

  final List<String> categories;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.description,
    required this.pages,
    required this.publishDate,
    required this.publisher,
    required this.rating,
    required this.fileUrl,
    required this.discount,
    required this.price,
    required this.discountPrice,
    required this.bookmark,
    required this.cart,
    required this.categories,
  });

  factory Book.fromFirestore(Map<String, dynamic> json, String id) {
    // ── tolerate three shapes: array, single string, missing field ──
    List<String> cats;
    if (json['categories'] is List) {
      cats = (json['categories'] as List)
          .map((e) => e.toString())
          .toList(growable: false);
    } else if (json['category'] is String &&
        (json['category'] as String).trim().isNotEmpty) {
      cats = [(json['category'] as String)];
    } else {
      cats = const []; // nothing set yet
    }
    return Book(
      id: id,
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      coverUrl: (json['cover_url'] ?? json['coverUrl'] ?? '') as String,
      description: json['description'] ?? '',
      pages: (json['pages'] ?? 0) as int,
      publishDate:
          (json['publish_date'] as Timestamp?)?.toDate() ?? DateTime(1900),
      publisher: json['publisher'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      fileUrl: (json['file_url'] ?? json['fileUrl'] ?? '') as String,
      categories: cats,
      discount: (json['discount'] ?? false) as bool,
      cart: (json['cart'] ?? false) as bool,
      bookmark: (json['bookmark'] ?? false) as bool,
      price: (json['price'] ?? 0).toDouble(),
      discountPrice: (json['discountPrice'] ?? 0).toDouble(),
    );
  }
}
