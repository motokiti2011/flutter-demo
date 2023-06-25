import 'package:flutter/material.dart';
import 'package:flutter_demo_rest_api/model/product.dart';

import '../view_model/Home_viewmodel.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final HomeViewModel homeViewModel = HomeViewModel();

  List<Product> products = [];
  Future getHomes() async {
    products = (await homeViewModel.fetchProducts())!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home List"),
      ),
      body: FutureBuilder(
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
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(products[index].productName),
                subtitle: Text(products[index].productId),
              ),
            );
          }
        },
      ),
    );
  }
}
