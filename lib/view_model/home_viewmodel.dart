import 'package:flutter_demo_rest_api/repository/product_repository.dart';

class HomeViewModel {
  final productRepository = ProductRepository();
  dynamic fetchProducts() async {
    return await productRepository.fetchProducts();
  }
}
