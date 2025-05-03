import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final String name;
  final String? parentId;   // nullable if you don’t use nesting

  Category({
    required this.name,
    this.parentId,
  });

  factory Category.fromFirestore(
      Map<String, dynamic> json, String id) {
    return Category(
      name: json['name'] ?? '',
      parentId: json['parentId'],
    );
  }
}
