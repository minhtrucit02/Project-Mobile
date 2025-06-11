import 'package:flutter/material.dart';

import '../../../models/shoes/product.dart';
import '../../../services/productl_service.dart';
import '../productCard.dart';

class PopularShoes extends StatelessWidget {
  final ProductService productService = ProductService();
  final void Function(int productId) onProductTap;


  PopularShoes({super.key, required this.onProductTap});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: productService.getAllProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Lỗi: ${snapshot.error}'));
        }

        final products = snapshot.data ?? [];

        if (products.isEmpty) {
          return const Center(child: Text('Không có sản phẩm nào.'));
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return GestureDetector(
              onTap: () => onProductTap(product.id),
              child: ProductCard(product: product),
            );          },
        );
      },
    );
  }
}
