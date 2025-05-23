import 'package:flutter/material.dart';
import 'package:phonestore/View/productdetailscreen.dart';
import 'package:provider/provider.dart';

import '../Provider/productprovider.dart';
import '../modal/producatmodal.dart';
class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);
    final isFavourite = provider.isFavourite(product);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(product: product),
          ),
        );
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image with favorite icon
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                      image: DecorationImage(
                        image: NetworkImage(product.thumbnail),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButton(
                      onPressed: () {
                        provider.toggleFavourite(product);
                      },
                      icon: Icon(
                        isFavourite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Product title and price
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text("\$${product.price.toStringAsFixed(2)}"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
