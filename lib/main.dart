import 'package:flutter/material.dart';

import 'package:flutter_demo_rest_api/view/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      theme: ThemeData(primarySwatch: Colors.lime),
      home: HomePage(),
    );
  }
}
