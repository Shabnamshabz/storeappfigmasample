import 'package:flutter/material.dart';
import 'package:phonestore/View/productcard.dart';
import 'package:provider/provider.dart';
import '../Provider/productprovider.dart';

class ProductSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
          }),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context, listen: false);
    final results = provider.allProducts.where((product) {
      final title = product.title.toLowerCase();
      final description = product.description.toLowerCase();
      final input = query.toLowerCase();

      return title.contains(input) || description.contains(input);
    }).toList();

    if (results.isEmpty) {
      return const Center(child: Text('No products found.'));
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ProductCard(product: results[index]);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context, listen: false);
    final suggestions = provider.allProducts.where((product) {
      final title = product.title.toLowerCase();
      final description = product.description.toLowerCase();
      final input = query.toLowerCase();

      return title.contains(input) || description.contains(input);
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index].title),
          onTap: () {
            query = suggestions[index].title;
            showResults(context);
          },
        );
      },
    );
  }
}
