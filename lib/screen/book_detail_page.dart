import 'package:flutter/material.dart';
import 'package:lumo/widget/add_to_cart_button.dart';

import '../design/design_config.dart';

class BookDetailPage extends StatelessWidget {
  const BookDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: DesignConfig.appBarBackgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            // Book cover
            Center(
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://edit.org/images/cat/book-covers-big-2019101610.jpg',
                    height: 220,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Title
            Container(
              margin: EdgeInsets.only(top: 20),
              // color: Colors.yellow,
              width: double.infinity,
              alignment: Alignment.centerLeft,
              child: const Text(
                'The Last Murder at the End of the WorldThe Last Murder at the End of the WorldThe Last Murder at the End of the World',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),

            // Rating + Icons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.star, color: Colors.amber, size: 20),
                Icon(Icons.star, color: Colors.amber, size: 20),
                Icon(Icons.star, color: Colors.amber, size: 20),
                Icon(Icons.star_border, color: Colors.amber, size: 20),
                Icon(Icons.star_border, color: Colors.amber, size: 20),
                SizedBox(width: 8),
                Text('(26)', style: TextStyle(color: Colors.grey)),
                Spacer(),
                Icon(Icons.favorite_border),
                SizedBox(width: 16),
                Icon(Icons.share),
              ],
            ),
            const SizedBox(height: 20),

            // Add to cart and price
            CartADButton
              (title: 'Add to cart',
                price: '24.50',
                discountPrice: '11.99',
            cardColor: DesignConfig.addCart),

            const SizedBox(height: 24),

            // Description
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Description',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: DesignConfig.textSize),
                ),
                Text('more >', style: TextStyle(color: Colors.orange)),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              "A mind-bending, genre-blending, boy-that-ending mystery unlike any I’ve ever read’ A. J. FINN "
              "‘I loved it’ C. J. TUDOR ‘An absolute blast’ BENJAMIN ...",
              style: TextStyle(color: Colors.black87),
            ),
            const SizedBox(height: 20),

            // Details
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: DesignConfig.textSize)),
                Text('more >', style: TextStyle(color: Colors.orange)),
              ],
            ),
            const Divider(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Author', style: TextStyle(color: Colors.grey)),
                Text('Stuart Turton'),
              ],
            ),
            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Genres', style: TextStyle(color: Colors.grey)),
                Text('Murder, Thrillers'),
              ],
            ),
            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Pages', style: TextStyle(color: Colors.grey)),
                Text('352 p'),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
