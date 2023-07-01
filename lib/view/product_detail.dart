import 'package:flutter/material.dart';
import 'package:flutter_demo_rest_api/model/product.dart';

import '../view_model/product_viewmodel.dart';
import '../model/productCategory.dart';

// ignore: must_be_immutable
class ProductDetail extends StatelessWidget {
  // ProductDetail({Key? key}) : super(key: key);
  ProductDetail(this.productId);
  String productId;

  final ProductViewModel productViewModel = ProductViewModel();

  List<Product> products = [];
  Future getHomes() async {
    products = (await productViewModel.getProduct(productId))!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("商品詳細"),
      ),
      body: Center(
        child: FutureBuilder(
          future: getHomes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Text("LOADING"),
              );
            } else {
              if (products.isEmpty) {
                return const Center(
                  child: Text("NO DATA"),
                );
              }
              return Column(
                children: [
                  Container(
                    color: Colors.red,
                    child: Text('商品名:' + products[0].productName),
                  ),
                  Container(
                    color: Colors.red,
                    child: Text('商品数:' + products[0].productQuantity),
                  ),
                  Container(
                    color: Colors.red,
                    child: Text('商品説明:' + products[0].productExplanation),
                  ),
                  Container(
                    color: Colors.red,
                    child: Text('商品登録者:' + products[0].productContributor),
                  ),
                  Container(
                    color: Colors.red,
                    child: Text('商品画像URL:' + products[0].productImageUrl),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
