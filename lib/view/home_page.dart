import 'package:flutter/material.dart';
import 'package:flutter_demo_rest_api/model/product.dart';

import '../view_model/Home_viewmodel.dart';
import '../model/productCategory.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final HomeViewModel homeViewModel = HomeViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home List"),
      ),
      body: Column(
        children: [
          Container(
            height: 500,
            // color: Colors.red,
            child: SelectBtnPage(),
          ),
        ],
      ),
    );
  }
}

class SelectBtnPage extends StatefulWidget {
  const SelectBtnPage({Key? key}) : super(key: key);

  @override
  State<SelectBtnPage> createState() => _SelectBtnPageState();
}

class _SelectBtnPageState extends State<SelectBtnPage> {
  var selectedValue = ProductCategory.food.name;
  final lists = <String>[
    ProductCategory.food.name,
    ProductCategory.chemicals.name,
    ProductCategory.autumn.name,
    ProductCategory.weapon.name
  ];

  List<Product> products = [];
  dynamic category = 'food';
  String? isSelectedItem = 'aaa';

  final HomeViewModel homeViewModel = HomeViewModel();
  Future getHomes() async {
    products = (await homeViewModel.fetchProducts(category))!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 200,
            color: Colors.red,
            child: DropdownButton<String>(
              value: selectedValue,
              items: lists
                  .map((String list) =>
                      DropdownMenuItem(value: list, child: Text(list)))
                  .toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedValue = value!;
                  if (selectedValue == ProductCategory.food.name) {
                    category = ProductCategory.food;
                  } else if (selectedValue == ProductCategory.chemicals.name) {
                    category = ProductCategory.chemicals;
                  } else if (selectedValue == ProductCategory.autumn.name) {
                    category = ProductCategory.autumn;
                  } else {
                    category = ProductCategory.weapon;
                  }
                });
              },
            ),
          ),
          Container(
            height: 200,
            color: Colors.blueGrey,
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
          ),
        ],
      ),
    );
  }
}
