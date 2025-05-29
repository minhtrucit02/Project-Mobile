import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddProductSizeForm extends StatefulWidget {
  const AddProductSizeForm({super.key, required this.productId});

  final int productId;

  @override
  State<AddProductSizeForm> createState() => _AddProductSizeFormState();
}

class _AddProductSizeFormState extends State<AddProductSizeForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final List<ProductSizeField> _productSizes = [];

  @override
  void initState() {
    super.initState();
    _addProductSize();
  }

  void _addProductSize() {
    setState(() {
      _productSizes.add(ProductSizeField(
        sizeController: TextEditingController(),
        quantityController: TextEditingController(),
        onDelete: () => _removeProductSize(_productSizes.length - 1),
      ));
    });
  }

  void _removeProductSize(int index) {
    if (_productSizes.length > 1) {
      setState(() {
        _productSizes[index].dispose();
        _productSizes.removeAt(index);
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final batch = FirebaseFirestore.instance.batch();
        final productSizesCollection = FirebaseFirestore.instance.collection('productSizes');

        final lastProductSize = await productSizesCollection
            .orderBy('id', descending: true)
            .limit(1)
            .get();

        var nextId = lastProductSize.docs.isEmpty ? 1 : lastProductSize.docs.first['id'] + 1;

        for (var productSize in _productSizes) {
          if (productSize.sizeController.text.isNotEmpty) {
            final doc = productSizesCollection.doc();
            batch.set(doc, {
              'id': nextId,
              'productId': widget.productId,
              'size': int.parse(productSize.sizeController.text.trim()),
              'quantity': int.parse(productSize.quantityController.text.trim()),
            });
            nextId++;
          }
        }

        await batch.commit();

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Thêm size thành công!')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Lỗi: ${e.toString()}')),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  void dispose() {
    for (var productSize in _productSizes) {
      productSize.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thêm size sản phẩm"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ...List.generate(
                _productSizes.length,
                (index) => ProductSizeFormField(
                  productSize: _productSizes[index],
                  showDeleteButton: _productSizes.length > 1,
                  index: index,
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: TextButton.icon(
                  onPressed: _addProductSize,
                  icon: const Icon(Icons.add_circle_outline),
                  label: const Text('Thêm size khác'),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text(
                        'Lưu size sản phẩm',
                        style: TextStyle(fontSize: 16),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductSizeField {
  final TextEditingController sizeController;
  final TextEditingController quantityController;
  final VoidCallback onDelete;

  ProductSizeField({
    required this.sizeController,
    required this.quantityController,
    required this.onDelete,
  });

  void dispose() {
    sizeController.dispose();
    quantityController.dispose();
  }
}

class ProductSizeFormField extends StatelessWidget {
  const ProductSizeFormField({
    super.key,
    required this.productSize,
    required this.showDeleteButton,
    required this.index,
  });

  final ProductSizeField productSize;
  final bool showDeleteButton;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Size ${index + 1}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (showDeleteButton)
                  IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: productSize.onDelete,
                    color: Colors.red,
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: productSize.sizeController,
                    decoration: InputDecoration(
                      labelText: 'Size',
                      hintText: 'Nhập size',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập size';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Size phải là số';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: productSize.quantityController,
                    decoration: InputDecoration(
                      labelText: 'Số lượng',
                      hintText: 'Nhập số lượng',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập số lượng';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Số lượng phải là số';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
