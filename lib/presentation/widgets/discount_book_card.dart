import 'package:flutter/material.dart';

import '../../core/config/design_config.dart';

class DiscountBookCard extends StatelessWidget {
  final String title;
  final String author;
  final String cover;
  final String price;

  const DiscountBookCard({
    Key? key,
    required this.title,
    required this.author,
    required this.cover,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Card with elevation & rounded corners
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: DesignConfig.shadowColor,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  cover,
                  height: 270,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Image.asset(
                  'assets/icon/tag.png',
                  height: 50,
                  width: 50,
                  fit: BoxFit.fill,
                ),
              ),

            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: DesignConfig.textSize),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          author,
          style: const TextStyle(color: DesignConfig.subTextColor, fontSize: DesignConfig.subTextSize),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: DesignConfig.priceColor),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            price,
            style: const TextStyle(color: DesignConfig.priceColor, fontSize: 12),
          ),
        ),
      ],
    );
  }
}
