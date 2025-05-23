// repository/apiservice.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../modal/categorymodal.dart';
import '../modal/producatmodal.dart';

class ApiService {
  final String baseUrl = 'https://dummyjson.com';

  Future<List<Product>> fetchAllProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final products = data['products'] as List;
      return products.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<ProductCategory>> fetchCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/products/categories'));

    if (response.statusCode == 200) {
      final List<dynamic> categoryList = json.decode(response.body);

      // Convert slugs to ProductCategory using fromSlug()
      return categoryList
          .map((slug) => ProductCategory.fromJson(slug))
          .toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<Product>> fetchProductsByCategory(String categorySlug) async {
    final response =
        await http.get(Uri.parse('$baseUrl/products/category/$categorySlug'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List productsJson = jsonData['products'];
      return productsJson.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products by category');
    }
  }


}
