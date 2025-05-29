import 'package:flutter/material.dart';
import 'package:shose_store/services/brand_service.dart';

import 'brandCard.dart';

class BrandList extends StatefulWidget {
  const BrandList({super.key});

  @override
  State<BrandList> createState() => _BrandListState();
}

class _BrandListState extends State<BrandList> {
  final BrandService brandService = BrandService();
  int selectedIndex = 0;

  Widget _buildLoadingShimmer() {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5, // Show 5 shimmer items while loading
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            width: 100,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.grey[300]!,
                  Colors.grey[100]!,
                  Colors.grey[300]!,
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
            child: const SizedBox(),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final listBrand = brandService.getAllBrands();

    return FutureBuilder(
      future: listBrand,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingShimmer();
        }

        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 32,
                ),
                const SizedBox(height: 8),
                Text(
                  "Lỗi: ${snapshot.error}",
                  style: const TextStyle(color: Colors.red),
                ),
              ],
            ),
          );
        }

        final products = snapshot.data ?? [];
        final brands = products
            .map((e) => {'brand': e.brand, 'imagePath': e.imagePath})
            .toSet()
            .toList();

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: SizedBox(
            key: ValueKey<int>(brands.length),
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: brands.length,
              itemBuilder: (context, index) {
                final brand = brands[index];
                return AnimatedOpacity(
                  duration: Duration(milliseconds: 200 + (index * 100)),
                  opacity: 1.0,
                  child: AnimatedSlide(
                    duration: Duration(milliseconds: 200 + (index * 100)),
                    offset: const Offset(0, 0),
                    child: BrandCard(
                      brand: brand['brand']!,
                      logo: 'assets/logo/${brand['imagePath']}',
                      isSelected: index == selectedIndex,
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
