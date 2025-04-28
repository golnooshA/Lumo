

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookCoverCard extends StatelessWidget{
  final String bookCover;
  final VoidCallback onTap;

  const BookCoverCard({super.key, required this.bookCover, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 120,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          // boxShadow: const [
          //   BoxShadow(
          //     color: Colors.black12,
          //     blurRadius: 4,
          //     offset: Offset(0, 2),
          //   ),
          // ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: Image.network(
            bookCover,
            height: 150,
            width: 120,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

}