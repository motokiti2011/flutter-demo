import 'package:flutter_demo_rest_api/repository/product_repository.dart';

class ProductViewModel {
  final productRepository = ProductRepository();
  dynamic getProduct(productId) async {
    return await productRepository.getProduct(productId);
  }
}
