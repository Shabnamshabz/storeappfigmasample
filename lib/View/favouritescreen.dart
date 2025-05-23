// screens/favourite_screen.dart
import 'package:flutter/material.dart';
import 'package:phonestore/View/productcard.dart';
import 'package:provider/provider.dart';
import '../Provider/productprovider.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'Favourites',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: provider.favourites.isEmpty
          ? const Center(
        child: Text(
          'No favourite products yet',
          style: TextStyle(fontSize: 18, color: Colors.black54),
        ),
      )
          : GridView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: provider.favourites.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          final product = provider.favourites[index];
          return ProductCard(product: product);
        },
      ),
    );
  }
}
