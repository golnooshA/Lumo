import 'package:flutter/material.dart';
import 'package:lumo/widget/purchest_card.dart';
import '../design/design_config.dart';
import '../widget/bottom_navigation.dart';

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
    _tabController = TabController(length: 2, vsync: this); // 2 tabs
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
            Tab(
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
                    child: const Text(
                      '4',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            const Tab(text: 'Previous Orders'),
          ],
        ),
      ),
      bottomNavigationBar:  const BottomNavigation(currentIndex: 4),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Cart Tab
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: 6,
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  itemBuilder: (context, index) {
                    return PurchestCard
                      (title: 'Think Less, Live MoreThink Less, Live More',
                        author: 'Anna Johanson',
                        discountPrice: 98.50,
                        price: '120.00',
                        cover: 'https://edit.org/images/cat/book-covers-big-2019101610.jpg');
                  },
                ),
              ),
              const Divider(),

              // Cart Summary
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
                        TextButton(
                          onPressed: () {},
                          child: const Text('Submit'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Total Items (4)', style: TextStyle(color: Colors.grey)),
                        Text('\u20AC98.50'),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Discount', style: TextStyle(color: Colors.grey)),
                        Text(
                          '\u20AC40.50',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Payable Amount', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('\u20AC40.50', style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Continue to Payment',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Previous Orders Tab
          const Center(
            child: Text('No previous orders', style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
