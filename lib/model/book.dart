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
  final String category;

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
    required this.category,
  });

  // Factory constructor to create Book object from Firestore document
  factory Book.fromFirestore(Map<String, dynamic> json, String id) {
    return Book(
      id: id,
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      coverUrl: json['cover_url'] ?? '',
      description: json['description'] ?? '',
      pages: (json['pages'] ?? 0) as int,
      publishDate: (json['publish_date'] as Timestamp).toDate(),
      publisher: json['publisher'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      fileUrl: json['file_url'] ?? '',
      category: json['category'] ?? '',
    );
  }
}
