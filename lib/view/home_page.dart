import 'package:flutter/material.dart';
import 'package:flutter_demo_rest_api/model/product.dart';

import '../view_model/Home_viewmodel.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final HomeViewModel homeViewModel = HomeViewModel();

  // List<Product> products = [];
  // dynamic category = 'food';
  // String? isSelectedItem = 'aaa';

  // Future getHomes() async {
  //   products = (await homeViewModel.fetchProducts(category))!;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home List"),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            color: Colors.red,
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
  var selectedValue = "food";
  final lists = <String>["food", "chemicals", "autumn", "weapon"];

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
                  category = selectedValue;
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
