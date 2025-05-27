import 'package:flutter/material.dart';
import 'package:shose_store/models/shoes/product.dart';
import 'package:shose_store/services/product_service.dart';

class GetAllProduct extends StatelessWidget {
   GetAllProduct({super.key});

  final ProductService productService =  ProductService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: StreamBuilder<List<Product>>(
        stream: productService.getAllProductsStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final products = snapshot.data ?? [];

          if (products.isEmpty) {
            return const Center(
              child: Text("No products found"),
            );
          }

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              print (product.imagePath);
              return ListTile(
                leading: Image.asset(
                  'assets/logo/${product.imagePath}',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image),
                ),
                title: Text(product.brand),
                subtitle: Text('ID: ${product.id}'),
              );
            },
          );
        },
      ),
    );
  }
}
