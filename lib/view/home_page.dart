import 'package:flutter/material.dart';
import 'package:flutter_demo_rest_api/model/product.dart';

import '../view_model/Home_viewmodel.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final HomeViewModel homeViewModel = HomeViewModel();

  List<Product> products = [];
  dynamic category = 'food';
  String? isSelectedItem = 'aaa';

  Future getHomes() async {
    products = (await homeViewModel.fetchProducts(category))!;
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //3
              DropdownButton(
                //4
                items: const [
                  //5
                  DropdownMenuItem(
                    child: Text('aaa'),
                    value: 'aaa',
                  ),
                  DropdownMenuItem(
                    child: Text('bbb'),
                    value: 'bbb',
                  ),
                  DropdownMenuItem(
                    child: Text('ccc'),
                    value: 'ccc',
                  ),
                ],
                //6
                onChanged: (String? value) {
                  // setState(() {
                  //   isSelectedItem = value;
                  // });
                },
                //7
                value: isSelectedItem,
              ),
              const SizedBox(
                height: 32,
              ),
              Text('$isSelectedItem が選択されました。')
            ],
          ),
        ),
      ),
    );
  }
}
