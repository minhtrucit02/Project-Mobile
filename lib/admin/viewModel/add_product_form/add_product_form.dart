import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shose_store/models/shoes/imageDetail.dart';
import 'package:shose_store/models/shoes/productSize.dart';
import '../../../models/shoes/product.dart';


class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _idController = TextEditingController();
  final _brandIdController = TextEditingController();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  final List<TextEditingController> _imageControllers = [];
  final List<Map<String, TextEditingController>> _sizeQuantityControllers = [];

  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref();

  void _addProductToFirebase() {
    final product = Product(
      id: int.parse(_idController.text),
      brandId: int.parse(_brandIdController.text),
      name: _nameController.text,
      price: double.tryParse(_priceController.text) ?? 0,
      description: _descriptionController.text,
      imageDetail: _imageControllers
          .map((controller) => ImageDetail(imagePath: controller.text))
          .toList(),
      productSize: _sizeQuantityControllers.map((pair) {
        final size = int.tryParse(pair['size']!.text);
        final quantity = int.tryParse(pair['quantity']!.text);

        return ProductSize(
          size: size ?? 0,
          quantity: quantity ?? 0,
        );
      }).toList(),
      createAt: Timestamp.now(),
    );

    _databaseRef
        .child('products')
        .child((product.id).toString())
        .set(product.toJson())
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sản phẩm đã được thêm thành công!')),
      );
    });
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
        ),
      ),
    );
  }

  Widget _buildDynamicList({
    required String title,
    required List<TextEditingController> controllers,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        ...controllers.map(
              (c) => _buildTextField("$title item", c),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              controllers.add(TextEditingController());
            });
          },
          child: Text("Thêm $title"),
        ),
      ],
    );
  }

  Widget _buildSizeQuantityList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Size & Số lượng", style: TextStyle(fontWeight: FontWeight.bold)),
        ..._sizeQuantityControllers.map((pair) {
          return Row(
            children: [
              Expanded(child: _buildTextField("Size", pair['size']!)),
              const SizedBox(width: 10),
              Expanded(child: _buildTextField("Số lượng", pair['quantity']!)),
            ],
          );
        }).toList(),
        TextButton(
          onPressed: () {
            setState(() {
              _sizeQuantityControllers.add({
                'size': TextEditingController(),
                'quantity': TextEditingController(),
              });
            });
          },
          child: const Text("Thêm Size"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thêm sản phẩm')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildTextField("ID", _idController),
            _buildTextField("Brand ID", _brandIdController),
            _buildTextField("Tên sản phẩm", _nameController),
            _buildTextField("Giá", _priceController),
            _buildTextField("Mô tả", _descriptionController),
            const SizedBox(height: 16),
            _buildDynamicList(title: "Hình ảnh", controllers: _imageControllers),
            const SizedBox(height: 16),
            _buildSizeQuantityList(),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _addProductToFirebase,
              child: const Text("Thêm sản phẩm"),
            ),
          ],
        ),
      ),
    );
  }
}
