import 'package:flutter/material.dart';
import 'package:shose_store/services/product_service.dart';

import 'brandCard.dart';

class BrandList extends StatefulWidget {
  const BrandList({super.key});

  @override
  State<BrandList> createState() => _BrandListState();
}

class _BrandListState extends State<BrandList> {
  final ProductService productService = ProductService();
  int selectedIndex = 0;

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

        // Lấy danh sách brand không trùng
        final brands = products
            .map((e) => {'brand': e.brand, 'imagePath': e.imagePath})
            .toSet()
            .toList();

        return SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: brands.length,
            itemBuilder: (context, index) {
              final brand = brands[index];

              return BrandCard(
                brand: brand['brand']!,
                logo: 'assets/logo/${brand['imagePath']}',
                isSelected: index == selectedIndex,
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              );
            },
          ),
        );
      },
    );
  }
}
