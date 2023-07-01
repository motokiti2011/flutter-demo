import 'package:flutter_demo_rest_api/service/api_client.dart';

class ProductRepository {
  final apiClient = ApiClient();
  dynamic fetchProducts(category) async {
    return await apiClient.fetchProducts(category);
  }

  dynamic getProduct(productId) async {
    return await apiClient.getProduct(productId);
  }
}
