import 'package:ecom_demo/models/product.dart';
import 'package:ecom_demo/providers/product_service.dart';
import 'package:ecom_demo/widgets/product_item.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  final productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: FutureBuilder<List<Product>>(
        future: productService.fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final products = snapshot.data!;
            return GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return ProductItem(product: products[index]);
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
