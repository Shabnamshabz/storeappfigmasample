// screens/product_screencateg.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/productprovider.dart';
import 'productcard.dart'; // Assuming this is your reusable card widget

class ProductScreencateg extends StatefulWidget {
  final String categorySlug;

  const ProductScreencateg({super.key, required this.categorySlug});

  @override
  State<ProductScreencateg> createState() => _ProductScreencategState();
}

class _ProductScreencategState extends State<ProductScreencateg> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context, listen: false)
        .fetchProductsByCategory(widget.categorySlug);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("${widget.categorySlug} Items",
            style: TextStyle(
            fontSize: 38,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            letterSpacing: 1.2,
            shadows: [
              Shadow(
                offset: Offset(1, 1),
                blurRadius: 3,
                color: Colors.white54,
              ),
            ],
          ),),
        ),
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: () => provider.fetchProductsByCategory(widget.categorySlug),
        child: GridView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: provider.products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            final product = provider.products[index];
            return ProductCard(product: product);
          },
        ),
      ),
    );
  }
}
