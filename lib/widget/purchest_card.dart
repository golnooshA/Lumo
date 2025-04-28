import 'package:flutter/material.dart';

class PurchestCard extends StatelessWidget {
  final String title;
  final String author;
  final String cover;
  final double discountPrice;
  final String price;

  const PurchestCard({
    super.key,
    required this.title,
    required this.discountPrice,
    required this.price,
    required this.cover, required this.author,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      // padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        // color: Colors.yellow,
        borderRadius: BorderRadius.circular(10),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 4,
        //     offset: Offset(0, 2),
        //   ),
        // ],
      ),
      child: Row(
        children: [
          // Book Cover Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              cover,
              height: 150,
              width: 100,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(width: 12),
          // Title + Prices
          Expanded(
            child: Container(
              height: 150, // ✅ Give height to force layout
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // ✅ Space between title-author and price
                children: [
                  // Top: Title + Author
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                    ],
                  ),

                  // Bottom: Prices
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
