import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shose_store/models/shoes/brand.dart';

class BrandService {
  final String baseUrl = 'https://shosestore-7c86e-default-rtdb.firebaseio.com';

  Future<void> addBrand(Brand brand) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/brands.json'));

      int newId = 1;
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data is Map<String, dynamic>) {
          final ids = data.keys
              .map((key) => int.tryParse(key.toString()) ?? 0)
              .toList()
            ..sort();
          newId = (ids.isNotEmpty ? ids.last + 1 : 1);
        }
      }

      final now = DateTime.now();
      final createdAt = DateFormat('yyyy-MM-dd').format(now);

      final newBrand = Brand(
        id: newId,
        name: brand.name,
        imagePath: brand.imagePath,
        createdAt: createdAt,
      );

      await http.put(
        Uri.parse('$baseUrl/brands/$newId.json'),
        body: json.encode(newBrand.toJson()),
      );
    } catch (e) {
      print('Lỗi khi thêm brand: $e');
      rethrow;
    }
  }

  Future<List<Brand>> getAllBrands() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/brands.json'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<Brand> brands = [];

        if (data != null && data is List) {
          for (var item in data) {
            if (item != null && item is Map<String, dynamic>) {
              try {
                final brand = Brand.fromJson(item);
                brands.add(brand);
              } catch (e) {
                print("Lỗi khi parse brand: $e | Dữ liệu: $item");
              }
            }
          }

          brands.sort((a, b) => a.id.compareTo(b.id));
          return brands;
        } else {
          print("Dữ liệu không hợp lệ: $data");
          return [];
        }
      } else {
        throw Exception('Lỗi khi tải dữ liệu: ${response.statusCode}');
      }
    } catch (e) {
      print('Lỗi khi lấy danh sách brand: $e');
      rethrow;
    }
  }
}
