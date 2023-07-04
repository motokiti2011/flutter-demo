import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter_demo_rest_api/repository/product_repository.dart';

class ProductViewModel {
  final productRepository = ProductRepository();
  dynamic getProduct(productId, CognitoJwtToken) async {
    return await productRepository.getProduct(productId, CognitoJwtToken);
  }
}
