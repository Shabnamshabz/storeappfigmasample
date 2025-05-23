// // screens/category_products_screen.dart
// import 'package:flutter/material.dart';
// import 'package:phonestore/View/productcard.dart';
// import 'package:provider/provider.dart';
// import '../Provider/productprovider.dart';
//
//
// class CategoryProductsScreen extends StatefulWidget {
//   final String categorySlug;
//   final String categoryName;
//
//   const CategoryProductsScreen({
//     super.key,
//     required this.categorySlug,
//     required this.categoryName,
//   });
//
//   @override
//   State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
// }
//
// class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Provider.of<ProductProvider>(context, listen: false).fetchProductsByCategory(widget.categorySlug);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<ProductProvider>(context);
//
//     if (provider.isLoadingCategoryProducts) {
//       return Scaffold(
//         appBar: AppBar(title: Text(widget.categoryName)),
//         body: const Center(child: CircularProgressIndicator()),
//       );
//     }
//
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.categoryName)),
//       body: GridView.builder(
//         padding: const EdgeInsets.all(8),
//         itemCount: provider.categoryProducts.length,
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           childAspectRatio: 0.75,
//           mainAxisSpacing: 8,
//           crossAxisSpacing: 8,
//         ),
//         itemBuilder: (context, index) {
//           final product = provider.categoryProducts[index];
//           return ProductCard(product: product);
//         },
//       ),
//     );
//   }
// }
