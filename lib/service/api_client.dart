import 'dart:convert';

import 'package:flutter_demo_rest_api/model/product.dart';

import 'package:http/http.dart' as http;

class ApiClient {
  Future<List<Product>?> fetchProducts() async {
    final url =
        Uri.parse('https://hausn48fya.execute-api.us-east-1.amazonaws.com/dev');
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
