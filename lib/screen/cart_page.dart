// ✅ FINAL UPDATED CARTPAGE WITH TOTAL CALCULATION
// - Dynamic cart totals (price, discount, payable amount)
// - Book purchase/payment and previous order tracking

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lumo/widget/cart_card.dart';
import '../design/design_config.dart';
import '../model/book.dart';
import '../widget/bottom_navigation.dart';
import '../widget/previous_order.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DesignConfig.appBarBackgroundColor,
        centerTitle: true,
        title: Text(
          'Cart',
          style: TextStyle(
            color: DesignConfig.appBarTitleColor,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: DesignConfig.appBarTitleFontSize,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.red,
          labelColor: Colors.red,
          unselectedLabelColor: Colors.grey,
          tabs: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('books')
                  .where('cart', isEqualTo: true)
                  .snapshots(),
              builder: (context, snap) {
                int count = snap.data?.docs.length ?? 0;
                return Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Cart'),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '$count',
                          style: const TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const Tab(text: 'Previous Orders'),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigation(currentIndex: 3),
      body: TabBarView(
        controller: _tabController,
        children: [
          // 🛒 CART TAB
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('books').where('cart', isEqualTo: true).snapshots(),
            builder: (context, snap) {
              if (!snap.hasData) return const Center(child: CircularProgressIndicator());

              final books = snap.data!.docs.map((d) => Book.fromFirestore(d.data()! as Map<String, dynamic>, d.id)).toList();

              if (books.isEmpty) return const Center(child: Text('No items in cart'));

              double totalPrice = books.fold(0.0, (sum, b) => sum + b.price);
              double totalDiscount = books.fold(0.0, (sum, b) => sum + (b.discountPrice > 0 ? (b.price - b.discountPrice) : 0));
              double payable = totalPrice - totalDiscount;

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: books.length,
                      itemBuilder: (_, i) => CartCard(
                        title: books[i].title,
                        author: books[i].author,
                        discountPrice: books[i].discountPrice,
                        price: books[i].price.toString(),
                        cover: books[i].coverUrl,
                        onTap: () {},
                        deleteTap: () async {
                          await FirebaseFirestore.instance
                              .collection('books')
                              .doc(books[i].id)
                              .update({'cart': false});
                        },
                      ),
                    ),
                  ),
                  const Divider(),
                  Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.grey[100],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Apply Discount Code'),
                            TextButton(onPressed: () {}, child: const Text('Submit')),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total Items (${books.length})', style: const TextStyle(color: Colors.grey)),
                            Text('€${totalPrice.toStringAsFixed(2)}'),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Discount', style: TextStyle(color: Colors.grey)),
                            Text('-€${totalDiscount.toStringAsFixed(2)}', style: const TextStyle(color: Colors.red)),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Payable Amount', style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('€${payable.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            onPressed: () async {
                              final cartBooks = await FirebaseFirestore.instance
                                  .collection('books')
                                  .where('cart', isEqualTo: true)
                                  .get();

                              for (var doc in cartBooks.docs) {
                                await doc.reference.update({'cart': false, 'purchased': true});
                              }

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Payment successful. Books moved to previous orders.')),
                              );
                            },
                            child: const Text('Continue to Payment', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),

          // 📦 PREVIOUS ORDERS TAB
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('books').where('purchased', isEqualTo: true).snapshots(),
            builder: (context, snap) {
              if (!snap.hasData) return const Center(child: CircularProgressIndicator());

              final books = snap.data!.docs.map((d) => Book.fromFirestore(d.data()! as Map<String, dynamic>, d.id)).toList();

              if (books.isEmpty) return const Center(child: Text('No previous orders'));

              return ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: books.length,
                itemBuilder: (_, i) => PreviousOrder(
                  title: books[i].title,
                  author: books[i].author,
                  discountPrice: books[i].discountPrice,
                  price: books[i].price.toString(),
                  cover: books[i].coverUrl,
                  onTap: () {},
                ),
              );
            },
          ),
        ],
      ),
    );
  }
} // END