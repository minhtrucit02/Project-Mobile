import 'package:flutter/material.dart';
import 'package:shose_store/services/product_service.dart';

class BrandList extends StatelessWidget {
  BrandList({super.key});
  final ProductService productService = ProductService();

  @override
  Widget build(BuildContext context) {
    final listBrand = productService.getAllProduct();

    return FutureBuilder(
      future: listBrand,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        final products = snapshot.data ?? [];

        final brands = products
            .map((e) => {'brand': e.brand, 'imagePath': e.imagePath})
            .toSet()
            .toList();

        return SizedBox(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: brands.length,
            itemBuilder: (context, index) {
              final brand = brands[index];
              return Container(
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/logo/${brand['imagePath']}',
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(width: 8),
                    // Text(
                    //   brand['brand']!,
                    //   style: const TextStyle(
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
