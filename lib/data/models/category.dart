// lib/data/models/category.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final String name;
  final String? parentId;

  Category({ required this.name, this.parentId });

  factory Category.fromFirestore(Map<String, dynamic> json, String id) {
    return Category(
      name: json['name']?.toString() ?? '',
      parentId: json['parentId']?.toString(),
    );
  }
}
