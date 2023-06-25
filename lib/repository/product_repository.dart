import 'package:flutter_demo_rest_api/service/api_client.dart';

class ProductRepository {
  final apiClient = ApiClient();
  dynamic fetchProducts() async {
    return await apiClient.fetchProducts();
  }
}
