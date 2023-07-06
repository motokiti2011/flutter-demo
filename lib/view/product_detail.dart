import 'package:flutter/material.dart';
import 'package:flutter_demo_rest_api/model/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../view_model/product_viewmodel.dart';
import '../model/productCategory.dart';
import '../service/cognito_provider.dart';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';

// ignore: must_be_immutable
class ProductDetail extends ConsumerWidget {
  // ProductDetail({Key? key}) : super(key: key);
  ProductDetail(this.productId);
  String productId;

  final ProductViewModel productViewModel = ProductViewModel();

  List<Product> products = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ログイン状況確認
    // final cognito = ref.watch(sessionProvider);
    final token = ref.watch(tockenProvider);

    // var cognitoUser = cognito as CognitoUserSession;
    // var token = cognitoUser.getIdToken().getJwtToken();
    Future getHomes() async {
      products = (await productViewModel.getProduct(productId, token))!;
    }

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
