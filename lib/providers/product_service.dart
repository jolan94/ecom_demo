import 'dart:convert';
import 'package:ecom_demo/models/product.dart';
import 'package:http/http.dart' as http;

class ProductService {
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));
    if (response.statusCode == 200) {
      final List<dynamic> parsedJson = jsonDecode(response.body);
      return parsedJson
          .map((json) => Product(
                id: json['id'].toString(),
                title: json['title'],
                description: json['description'],
                price: json['price'].toDouble(),
                imageUrl: json['image'],
              ))
          .toList();
    } else {
      throw Exception('Failed to fetch products');
    }
  }
}
