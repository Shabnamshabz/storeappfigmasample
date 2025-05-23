// screens/category_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/productprovider.dart';
import 'productcategoryby.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ProductProvider>(context, listen: false).fetchCategories();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);

    // Show filtered categories if searching, else all categories
    final categoriesToShow = provider.isCategorySearching
        ? provider.filteredCategories
        : provider.categories;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Hide keyboard when tapping outside
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: const Text(
            "Categories",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.2,
              shadows: [
                Shadow(
                  offset: Offset(1, 1),
                  blurRadius: 3,
                  color: Colors.white54,
                ),
              ],
            ),
          ),
        ),
        body: provider.isLoadingCategories
            ? const Center(child: CircularProgressIndicator())
            : Column(
          children: [
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: TextField(
                controller: _searchController,
                onChanged: provider.searchCategories,
                onSubmitted: (_) {
                  FocusScope.of(context).unfocus(); // Hide keyboard on submit
                },
                decoration: InputDecoration(
                  hintText: 'Search categories...',
                  hintStyle: const TextStyle(color: Colors.black87),
                  prefixIcon: const Icon(Icons.search, color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide:
                    BorderSide(color: Colors.black, width: 2),
                  ),
                ),
                cursorColor: Colors.black,
                style: const TextStyle(color: Colors.black),
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                    vertical: 12, horizontal: 16),
                itemCount: categoriesToShow.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final category = categoriesToShow[index];
                  return Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    elevation: 4,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        FocusScope.of(context)
                            .unfocus(); // Hide keyboard on tap
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductScreencateg(
                                categorySlug: category.slug),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 24, horizontal: 16),
                        alignment: Alignment.center,
                        child: Text(
                          category.name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
