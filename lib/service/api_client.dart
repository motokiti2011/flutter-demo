import 'dart:convert';

import 'package:flutter_demo_rest_api/model/product.dart';

import 'package:http/http.dart' as http;

class ApiClient {
  Future<List<Product>?> fetchProducts() async {
    final url = Uri.parse('http://123.45.678.9:8080/HomeList');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> body = jsonDecode(response.body);
        final List<Product> products =
            body.map((dynamic product) => Product.fromJson(product)).toList();
        return products;
      } else {
        return null;
      }
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
    return null;
  }
}
