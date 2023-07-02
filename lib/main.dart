import 'package:flutter/material.dart';

import 'package:flutter_demo_rest_api/view/home_page.dart';
// import 'package:amazon_cognito_identity_dart_2/cognito.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // final userPool = new CognitoUserPool(
  //     '[プールID ex. us-east-1_s4LArrEvf]', '[78k9h6n05ov1agltr1frht7e5n]');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      theme: ThemeData(primarySwatch: Colors.lime),
      home: HomePage(),
    );
  }
}
