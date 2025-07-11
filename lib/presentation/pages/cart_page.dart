import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/config/design_config.dart';
import '../providers/book_provider.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/cart_card.dart';
import '../widgets/previous_order.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

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
    final cartAsync      = ref.watch(cartBooksProvider);
    final purchasedAsync = ref.watch(purchasedBooksProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: DesignConfig.appBarBackgroundColor,
        centerTitle: true,
        title: const Text('Cart'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: DesignConfig.addCart,
          labelColor: DesignConfig.addCart,
          unselectedLabelColor: Colors.grey,
          tabs: [
            cartAsync.when(
              data: (list) => Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Cart'),
                    const SizedBox(width: 6),
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.red,
                      child: Text(
                        '${list.length}',
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              loading: ()    => const Tab(text: 'Cart'),
              error:   (_,__)=> const Tab(text: 'Cart'),
            ),
            const Tab(text: 'Previous'),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigation(currentIndex: 3),
      body: TabBarView(
        controller: _tabController,
        children: [
          // 🛒 In‐Cart Items
          cartAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error:   (e,_) => Center(child: Text('Error: $e')),
            data:    (books) {
              if (books.isEmpty) {
                return const Center(child: Text('No items in cart'));
              }
              final total    = books.fold<double>(0, (sum, b) => sum + b.price);
              final discount = books.fold<double>(0, (sum, b) =>
              sum + (b.discountPrice > 0 ? (b.price - b.discountPrice) : 0)
              );
              final payable  = total - discount;

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: books.length,
                      itemBuilder: (_, i) {
                        final b = books[i];
                        return CartCard(
                          title: b.title,
                          author: b.author,
                          price: b.price.toStringAsFixed(2),
                          discountPrice: b.discountPrice,
                          cover: b.coverUrl,
                          deleteTap: () =>
                              ref.read(bookRepoProvider).toggleCart(b.id, false),
                          onTap: () {}, // navigate or inspect
                        );
                      },
                    ),
                  ),
                  const Divider(),
                  _buildSummary(total, discount, payable),
                ],
              );
            },
          ),

          // 📦 Previous Orders
          purchasedAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error:   (e,_) => Center(child: Text('Error: $e')),
            data:    (books) {
              if (books.isEmpty) {
                return const Center(child: Text('No previous orders'));
              }
              return ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: books.length,
                itemBuilder: (_, i) {
                  final b = books[i];
                  return PreviousOrder(
                    title: b.title,
                    author: b.author,
                    price: b.price.toStringAsFixed(2),
                    discountPrice: b.discountPrice,
                    cover: b.coverUrl,
                    onTap: () {},
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSummary(double total, double discount, double payable) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey[100],
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total', style: const TextStyle(color: Colors.grey)),
              Text('${total.toStringAsFixed(2)} €'),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Discount', style: TextStyle(color: Colors.red)),
              Text('-${discount.toStringAsFixed(2)} €'),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Payable', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('${payable.toStringAsFixed(2)} €',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => ref.read(bookRepoProvider).purchaseAllCart(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Checkout',
                  style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
