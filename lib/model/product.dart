import 'dart:convert';

class Product {
  final String productId; // 商品ID
  final String productName; // 商品名
  final String productCategory; // 商品カテゴリー
  final String productQuantity; // 商品数
  final String productExplanation; // 商品説明
  final String productContributorId; // 商品登録者ID
  final String productContributor; // 商品登録者
  final String productImageUrl; // 商品画像URL

  Product({
    required this.productId,
    required this.productName,
    required this.productCategory,
    required this.productQuantity,
    required this.productExplanation,
    required this.productContributorId,
    required this.productContributor,
    required this.productImageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["productId"],
        productName: json["productName"],
        productCategory: json["productCategory"],
        productQuantity: json["productQuantity"],
        productExplanation: json["productExplanation"],
        productContributorId: json["productContributorId"],
        productContributor: json["productContributor"],
        productImageUrl: json["productImageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "productName": productName,
        "productCategory": productCategory,
        "productQuantity": productQuantity,
        "productExplanation": productExplanation,
        "productContributorId": productContributorId,
        "productContributor": productContributor,
        "productImageUrl": productImageUrl,
      };
}

Product productModelFromJson(String str) => Product.fromJson(json.decode(str));

String productModelToJson(Product product) => json.encode(product.toJson());
