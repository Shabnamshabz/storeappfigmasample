import 'package:flutter/material.dart';
import 'package:phonestore/View/categoryscreen.dart';
import 'package:phonestore/View/splashpage.dart';
import 'package:provider/provider.dart';
import 'Provider/productprovider.dart';
import 'View/homescreen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Splashpage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
