import 'dart:convert';

import 'package:flutter_demo_rest_api/model/product.dart';

import 'package:http/http.dart' as http;

class ApiClient {
  Future<List<Product>?> fetchProducts() async {
    final url = Uri.parse(
        'https://hausn48fya.execute-api.us-east-1.amazonaws.com/dev/productlist');

    var request = new SampleRequest(query: 'QUERY', category: 'food');

    try {
      final response = await http.post(url,
          body: json.encode(request.toJson()),
          headers: {"Content-Type": "application/json"});
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

class SampleRequest {
  final String query;
  final String category;
  SampleRequest({
    required this.query,
    required this.category,
  });
  Map<String, dynamic> toJson() => {
        'OperationType': query,
        'Keys': {
          'productCategory': category,
        }
      };
}
