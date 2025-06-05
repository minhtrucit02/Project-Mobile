import 'package:flutter/material.dart';
import 'package:shose_store/services/brand_service.dart';
import 'package:shose_store/models/shoes/brand.dart';

class GetAllBrand extends StatefulWidget {
  const GetAllBrand({super.key});

  @override
  State<GetAllBrand> createState() => _GetAllBrandState();
}

class _GetAllBrandState extends State<GetAllBrand> {
  final BrandService brandService = BrandService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tất cả thương hiệu")),
      body: FutureBuilder<List<Brand>>(
        future: brandService.getAllBrands(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Không có thương hiệu nào.'));
          }

          final brands = snapshot.data!;

          return ListView.builder(
            itemCount: brands.length,
            itemBuilder: (context, index) {
              final brand = brands[index];
              return Card(
                child: ListTile(
                  leading: Image.asset(
                    'assets/logo/${brand.imagePath}',
                    width: 50,
                    height: 50,
                    errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image_not_supported),
                  ),
                  title: Text(brand.name),
                  subtitle: Text("ID: ${brand.id} - Ngày tạo: ${brand.createdAt}"),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
