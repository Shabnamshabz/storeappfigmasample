import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:phonestore/View/productscreen.dart';
import 'package:phonestore/View/categoryscreen.dart';
import 'package:phonestore/View/favouritescreen.dart';
import 'package:phonestore/View/userprofilepage.dart';
import '../Provider/productprovider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    const ProductScreen(),
    const CategoryScreen(),
    const FavouriteScreen(),
    const UserScreen(),
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ProductProvider>(context, listen: false).fetchAllProducts();
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Provider.of<ProductProvider>(context, listen: false).clearSearch();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: 'Products'),
            BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Categories'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'User'),
          ],
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
