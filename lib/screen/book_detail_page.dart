import 'package:flutter/material.dart';
import 'package:lumo/widget/add_to_cart_button.dart';
import '../design/design_config.dart';
import '../model/book.dart';
import 'description_page.dart';

class BookDetailPage extends StatelessWidget {

  final Book book;
  const BookDetailPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    double discountPrice = book.price * (1 - book.price / 100).roundToDouble();

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
                    book.coverUrl,
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
              child:  Text(
                book.title,
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
              children:  [
                Icon(Icons.star, color: Colors.amber, size: 20),
                Icon(Icons.star, color: Colors.amber, size: 20),
                Icon(Icons.star, color: Colors.amber, size: 20),
                Icon(Icons.star_border, color: Colors.amber, size: 20),
                Icon(Icons.star_border, color: Colors.amber, size: 20),
                SizedBox(width: 8),
                Text(book.rating.toString(), style: TextStyle(color: Colors.grey)),
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
                price: book.price.toString(),
                discountPrice: discountPrice.toString(),
            cardColor: DesignConfig.addCart),

            const SizedBox(height: 24),

            // Description
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DescriptionPage(
                    description: book.description,
                  ),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Description',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: DesignConfig.textSize)),
                  Text('more >', style: TextStyle(color: Colors.orange)),
                ],
              ),
            ),

            const SizedBox(height: 8),
            Text(
              book.description,
              maxLines: 5,                         // ▶︎ only 5 lines
              overflow: TextOverflow.ellipsis,     // ▶︎ fade with “…”
              style: const TextStyle(color: Colors.black87),
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
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Author', style: TextStyle(color: Colors.grey)),
                Text(book.author),
              ],
            ),
            const SizedBox(height: 8),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Genres', style: TextStyle(color: Colors.grey)),
                Text(book.category),
              ],
            ),
            const SizedBox(height: 8),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Pages', style: TextStyle(color: Colors.grey)),
                Text(book.pages.toString()),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
