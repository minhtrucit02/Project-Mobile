import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shose_store/models/shoes/brand.dart';
import 'package:shose_store/services/brand_service.dart';

class AddBrand extends StatefulWidget {
  const AddBrand({super.key});

  @override
  State<AddBrand> createState() => _AddBrandState();
}

class _AddBrandState extends State<AddBrand> {
  final _formKey = GlobalKey<FormState>();
  final _nameBrandController = TextEditingController();
  final _imageBrandController = TextEditingController();

  @override
  void dispose() {
    _nameBrandController.dispose();
    _imageBrandController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if(_formKey.currentState!.validate()){
      final brand = Brand(
        id: 0,
        name: _nameBrandController.text,
        imagePath: _imageBrandController.text,
        createdAt: '',
      );
      try{
        await BrandService().addBrand(brand);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Add successfully")));
        _nameBrandController.clear();
        _imageBrandController.clear();
      }catch(e){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Bug: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Brand",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameBrandController,
                decoration: InputDecoration(
                  labelText: 'Brand Name',
                  hintText: 'Enter brand name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.shopping_bag_outlined),
                ),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter brand name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _imageBrandController,
                decoration: InputDecoration(
                  labelText: 'Image',
                  hintText: 'Enter image ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.image_outlined),
                ),
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter image URL';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Add Brand',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
