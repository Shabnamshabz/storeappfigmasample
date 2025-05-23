// providers/product_provider.dart
import 'package:flutter/material.dart';
import '../Repository/apiservice.dart';
import '../modal/categorymodal.dart';
import '../modal/producatmodal.dart';

class ProductProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Product> _products = []; // Category-specific products
  List<Product> get products => _products;

  List<ProductCategory> _categories = [];
  List<ProductCategory> get categories => _categories;

  List<ProductCategory> _filteredCategories = [];
  List<ProductCategory> get filteredCategories => _filteredCategories;

  List<Product> _allProducts = [];
  List<Product> get allProducts => _allProducts;

  List<Product> _favourites = [];
  List<Product> get favourites => _favourites;

  bool isLoading = false;
  bool isLoadingCategories = false;

  bool _isCategorySearching = false;
  bool get isCategorySearching => _isCategorySearching;

  // Fetch products for a category
  Future<void> fetchProductsByCategory(String slug) async {
    try {
      isLoading = true;
      notifyListeners();

      _products = await _apiService.fetchProductsByCategory(slug);

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      print('Error fetching products: $e');
      notifyListeners();
    }
  }

  // Fetch all products
  Future<void> fetchAllProducts() async {
    try {
      isLoading = true;
      notifyListeners();

      _allProducts = await _apiService.fetchAllProducts();

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      print('Error fetching all products: $e');
      notifyListeners();
    }
  }

  // Fetch categories
  Future<void> fetchCategories() async {
    try {
      isLoadingCategories = true;
      notifyListeners();

      _categories = await _apiService.fetchCategories();
      _filteredCategories = _categories; // Initialize filtered list

      isLoadingCategories = false;
      notifyListeners();
    } catch (e) {
      isLoadingCategories = false;
      print('Error fetching categories: $e');
      notifyListeners();
    }
  }

  // Favourite handling
  void toggleFavourite(Product product) {
    if (_favourites.contains(product)) {
      _favourites.remove(product);
    } else {
      _favourites.add(product);
    }
    notifyListeners();
  }

  bool isFavourite(Product product) => _favourites.contains(product);

  // Products search (existing)
  List<Product> _searchResults = [];
  List<Product> get searchResults => _searchResults;

  bool _isSearching = false;
  bool get isSearching => _isSearching;

  void searchProducts(String keyword) {
    if (keyword.isEmpty) {
      _isSearching = false;
      _searchResults = [];
    } else {
      _isSearching = true;
      final query = keyword.toLowerCase();

      _searchResults = _allProducts.where((product) {
        final titleLower = product.title.toLowerCase();
        final categoryLower = product.category.toLowerCase();
        final descLower = product.description.toLowerCase();

        return titleLower.contains(query) ||
            categoryLower.contains(query) ||
            descLower.contains(query);
      }).toList();
    }
    notifyListeners();
  }

  void clearSearch() {
    _isSearching = false;
    _searchResults = [];
    notifyListeners();
  }

  // *** New Category Search ***

  void searchCategories(String keyword) {
    if (keyword.isEmpty) {
      _isCategorySearching = false;
      _filteredCategories = _categories;
    } else {
      _isCategorySearching = true;
      final query = keyword.toLowerCase();

      _filteredCategories = _categories.where((category) {
        return category.name.toLowerCase().contains(query);
      }).toList();
    }
    notifyListeners();
  }

  void clearCategorySearch() {
    _isCategorySearching = false;
    _filteredCategories = _categories;
    notifyListeners();
  }
}


// // providers/product_provider.dart
// import 'package:flutter/material.dart';
// import '../Repository/apiservice.dart';
// import '../modal/categorymodal.dart';
// import '../modal/producatmodal.dart';
//
// class ProductProvider extends ChangeNotifier {
//   final ApiService _apiService = ApiService();
//
//   List<Product> _products = []; // This is used for category-specific products
//   List<Product> get products => _products;
//
//   List<ProductCategory> _categories = [];
//   List<ProductCategory> get categories => _categories;
//
//   List<Product> _allProducts = []; // Optional: full list
//   List<Product> get allProducts => _allProducts;
//
//   List<Product> _favourites = [];
//   List<Product> get favourites => _favourites;
//
//   bool isLoading = false;
//   bool isLoadingCategories = false;
//
//   // ✅ Fetch products for a category
//   Future<void> fetchProductsByCategory(String slug) async {
//     try {
//       isLoading = true;
//       notifyListeners();
//
//       _products = await _apiService.fetchProductsByCategory(slug);
//
//       isLoading = false;
//       notifyListeners();
//     } catch (e) {
//       isLoading = false;
//       print('Error fetching products: $e');
//       notifyListeners();
//     }
//   }
//
//   // ✅ Fetch all products (optional use)
//   Future<void> fetchAllProducts() async {
//     try {
//       isLoading = true;
//       notifyListeners();
//
//       _allProducts = await _apiService.fetchAllProducts();
//
//       isLoading = false;
//       notifyListeners();
//     } catch (e) {
//       isLoading = false;
//       print('Error fetching all products: $e');
//       notifyListeners();
//     }
//   }
//
//   // ✅ Fetch categories
//   Future<void> fetchCategories() async {
//     try {
//       isLoadingCategories = true;
//       notifyListeners();
//
//       _categories = await _apiService.fetchCategories();
//
//       isLoadingCategories = false;
//       notifyListeners();
//     } catch (e) {
//       isLoadingCategories = false;
//       print('Error fetching categories: $e');
//       notifyListeners();
//     }
//   }
//
//   // ✅ Favourite handling
//   void toggleFavourite(Product product) {
//     if (_favourites.contains(product)) {
//       _favourites.remove(product);
//     } else {
//       _favourites.add(product);
//     }
//     notifyListeners();
//   }
//
//   bool isFavourite(Product product) => _favourites.contains(product);
//   // In product_provider.dart
//
//   List<Product> _searchResults = [];
//   List<Product> get searchResults => _searchResults;
//
//   bool _isSearching = false;
//   bool get isSearching => _isSearching;
//
//   // Call this method with search query
//   void searchProducts(String keyword) {
//     if (keyword.isEmpty) {
//       _isSearching = false;
//       _searchResults = [];
//     } else {
//       _isSearching = true;
//       final query = keyword.toLowerCase();
//
//       _searchResults = _allProducts.where((product) {
//         final titleLower = product.title.toLowerCase();
//         final categoryLower = product.category.toLowerCase();
//         final descLower = product.description.toLowerCase();
//
//         return titleLower.contains(query) ||
//             categoryLower.contains(query) ||
//             descLower.contains(query);
//       }).toList();
//     }
//     notifyListeners();
//   }
//
//   void clearSearch() {
//     _isSearching = false;
//     _searchResults = [];
//     notifyListeners();
//   }
//
// }
