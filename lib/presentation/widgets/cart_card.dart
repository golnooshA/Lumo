import 'package:flutter/material.dart';
import 'package:lumo/core/config/design_config.dart';

class CartCard extends StatelessWidget {
  final String title;
  final String author;
  final String cover;
  final double discountPrice;
  final String price;
  final VoidCallback deleteTap;
  final VoidCallback onTap;

  const CartCard({
    super.key,
    required this.title,
    required this.discountPrice,
    required this.price,
    required this.cover,
    required this.author,
    required this.deleteTap,
    required this.onTap,
  });

  @override
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onTap,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                cover,
                height: 150,
                width: 100,
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Container(
              height: 150,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title + author
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    author,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const Spacer(),

                  Text(
                    '€ $price',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '€ $discountPrice',
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          IconButton(
            onPressed: deleteTap,
            icon: const Icon(Icons.delete_outline, size: 28),
            color: DesignConfig.deleteCart,
          ),
        ],
      ),
    );
  }
}