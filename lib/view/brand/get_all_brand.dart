import 'package:flutter/material.dart';
import 'package:shose_store/services/brand_service.dart';
import 'package:shose_store/admin/viewModel/add_product_form/add_product_form.dart';

class GetAllBrand extends StatelessWidget {
  GetAllBrand({super.key});

  final BrandService brandService = BrandService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Brand"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: brandService.getAllBrands(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No brands found."));
          }

          final brands = snapshot.data!;
          return ListView.builder(
            itemCount: brands.length,
            itemBuilder: (context, index) {
              final brand = brands[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  title: Text(brand.brand),
                  trailing: brand.imagePath.isNotEmpty
                      ? Image.asset(
                    'assets/logo/${brand.imagePath}',
                    width: 65,
                    height: 40,
                    fit: BoxFit.cover,
                  )
                      : const Icon(Icons.image_not_supported),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddProductForm(brand: brand,)));
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
