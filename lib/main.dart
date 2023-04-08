import 'package:ecom_demo/providers/cart_provider.dart';
import 'package:ecom_demo/screens/cart_screen.dart';
import 'package:ecom_demo/screens/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        title: 'E-Commerce App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ProductsScreen(),
        routes: {
          CartScreen.routeName: (ctx) => CartScreen(),
        },
      ),
    );
  }
}
