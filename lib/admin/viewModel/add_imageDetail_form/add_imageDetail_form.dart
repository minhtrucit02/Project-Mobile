import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class AddImageDetailForm extends StatefulWidget {
  const AddImageDetailForm({super.key, required this.productId});

  final int productId;

  @override
  State<AddImageDetailForm> createState() => _AddImageDetailFormState();
}

class _AddImageDetailFormState extends State<AddImageDetailForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final List<ImageDetailField> _imageDetails = [];

  @override
  void initState() {
    super.initState();
    _addImageDetail();
  }

  void _addImageDetail() {
    setState(() {
      _imageDetails.add(ImageDetailField(
        pathController: TextEditingController(),
        onDelete: () => _removeImageDetail(_imageDetails.length - 1),
      ));
    });
  }

  void _removeImageDetail(int index) {
    if (_imageDetails.length > 1) {
      setState(() {
        _imageDetails[index].dispose();
        _imageDetails.removeAt(index);
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
        final imageDetailsCollection = FirebaseFirestore.instance.collection('imageDetails');

        final lastImageDetail = await imageDetailsCollection
            .orderBy('id', descending: true)
            .limit(1)
            .get();
        
        var nextId = lastImageDetail.docs.isEmpty ? 1 : lastImageDetail.docs.first['id'] + 1;

        for (var imageDetail in _imageDetails) {
          if (imageDetail.pathController.text.isNotEmpty) {
            final doc = imageDetailsCollection.doc();
            batch.set(doc, {
              'id': nextId,
              'productId': widget.productId,
              'imageDetail': imageDetail.pathController.text.trim(),
            });
            nextId++;
          }
        }

        await batch.commit();

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Thêm hình ảnh thành công!')),
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
    for (var imageDetail in _imageDetails) {
      imageDetail.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thêm hình ảnh sản phẩm"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ...List.generate(
                _imageDetails.length,
                (index) => ImageDetailFormField(
                  imageDetail: _imageDetails[index],
                  showDeleteButton: _imageDetails.length > 1,
                  index: index,
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: TextButton.icon(
                  onPressed: _addImageDetail,
                  icon: const Icon(Icons.add_photo_alternate),
                  label: const Text('Thêm hình ảnh khác'),
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
                        'Lưu hình ảnh',
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

class ImageDetailField {
  final TextEditingController pathController;
  final VoidCallback onDelete;

  ImageDetailField({
    required this.pathController,
    required this.onDelete,
  });

  void dispose() {
    pathController.dispose();
  }
}

class ImageDetailFormField extends StatelessWidget {
  const ImageDetailFormField({
    super.key,
    required this.imageDetail,
    required this.showDeleteButton,
    required this.index,
  });

  final ImageDetailField imageDetail;
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
                  'Hình ảnh ${index + 1}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (showDeleteButton)
                  IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: imageDetail.onDelete,
                    color: Colors.red,
                  ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: imageDetail.pathController,
              decoration: InputDecoration(
                labelText: 'Đường dẫn hình ảnh',
                hintText: 'Nhập đường dẫn hình ảnh',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập đường dẫn hình ảnh';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
