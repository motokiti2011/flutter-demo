import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter_demo_rest_api/service/api_client.dart';

class ProductRepository {
  final apiClient = ApiClient();
  dynamic fetchProducts(category) async {
    return await apiClient.fetchProducts(category);
  }

  dynamic getProduct(productId, CognitoJwtToken) async {
    return await apiClient.getProduct(productId, CognitoJwtToken);
  }
}
