import 'package:flutter/material.dart';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import '../view/home_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_demo_rest_api/model/product.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final userPool =
    CognitoUserPool('us-east-1_s4LArrEvf', '78k9h6n05ov1agltr1frht7e5n');

// CognitoUserSession? session;
// Cognito認証情報の受け渡しを行うためのProvider
final session = StateProvider((ref) {
  return CognitoUserSession;
});

class CognitoInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'login sample app',
      routes: <String, WidgetBuilder>{
        '/': (_) => new CognitoInfoPage(),
        '/HomePage': (_) => new HomePage(),
        '/RegisterUser': (_) => new RegisterUserPage(),
        '/ConfirmRegistration': (_) => new ConfirmRegistration(null),
      },
    );
  }
}

class CognitoInfoPage extends ConsumerWidget {
  final _mailAddressController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        // 左側のアイコン
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          icon: Icon(Icons.arrow_back),
        ),

        title: Text('ログイン'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'test@examle.com',
                  labelText: 'メールアドレス',
                ),
                controller: _mailAddressController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'password',
                  labelText: 'パスワード',
                ),
                obscureText: true,
                controller: _passwordController,
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                child: Text('ログイン'),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.indigo),
                  // ↑< >に型を指定する
                ),
                // color: Colors.indigo,
                // shape: StadiumBorder(),
                // textColor: Colors.white,
                onPressed: () => _signIn(context, ref),
              ),
            ),
            Divider(color: Colors.black),
            ElevatedButton(
              child: Text('新しいアカウントの作成'),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.indigo),
                // ↑< >に型を指定する
              ),
              onPressed: () => Navigator.of(context).pushNamed('/RegisterUser'),
              // child: Text('新しいアカウントの作成'),
              // color: Colors.indigo,
              // textColor: Colors.white,
              // shape: StadiumBorder(),
              // onPressed: () => Navigator.of(context).pushNamed('/RegisterUser'),
            ),
          ],
        ),
      ),
    );
  }

  void _signIn(BuildContext context, WidgetRef ref) async {
    var cognitoUser = new CognitoUser(_mailAddressController.text, userPool);
    var authDetails = new AuthenticationDetails(
        username: _mailAddressController.text,
        password: _passwordController.text);
    try {
      var hoge = await cognitoUser.authenticateUser(authDetails);

      ref.read(session.notifier).state = hoge as Type;
      // context.read(session).state =
      // await cognitoUser.authenticateUser(authDetails);
      // session = await cognitoUser.authenticateUser(authDetails);
      Navigator.of(context).pushReplacementNamed('/TopPage');
    } catch (e) {
      await showDialog<int>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('エラー'),
            // content: Text(e.message),
            content: Text(e.toString()),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(1),
              ),
            ],
          );
        },
      );
    }
  }
}

class RegisterUserPage extends StatelessWidget {
  final _mailAddressController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 左側のアイコン
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('アカウント作成'),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'test@examle.com',
                    labelText: 'メールアドレス',
                  ),
                  controller: _mailAddressController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'password',
                    labelText: 'パスワード',
                  ),
                  obscureText: true,
                  controller: _passwordController,
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  child: Text('登録'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.indigo),
                    // ↑< >に型を指定する
                  ),
                  // color: Colors.indigo,
                  // shape: StadiumBorder(),
                  // textColor: Colors.white,
                  onPressed: () => _signUp(context),
                ),
              ),
            ]),
      ),
    );
  }

  void _signUp(BuildContext context) async {
    try {
      CognitoUserPoolData userPoolData = await userPool.signUp(
          _mailAddressController.text, _passwordController.text);
      Navigator.push(
        context,
        new MaterialPageRoute<Null>(
          settings: const RouteSettings(name: "/ConfirmRegistration"),
          builder: (BuildContext context) => ConfirmRegistration(userPoolData),
        ),
      );
    } on CognitoClientException catch (e) {
      await showDialog<int>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('エラー'),
            content: Text(e.message as String),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(1),
              ),
            ],
          );
        },
      );
    }
  }
}

class ConfirmRegistration extends StatelessWidget {
  final _registrationController = TextEditingController();

  CognitoUserPoolData? _userPoolData;
  ConfirmRegistration(this._userPoolData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 左側のアイコン
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('レジストレーションキー確認'),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(_userPoolData!.user.username as String),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'レジストレーションコード',
                    labelText: 'レジストレーションコード',
                  ),
                  obscureText: true,
                  controller: _registrationController,
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 8.0),
                child: ElevatedButton(
                  child: Text('確認'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.indigo),
                    // ↑< >に型を指定する
                  ),
                  // color: Colors.indigo,
                  // shape: StadiumBorder(),
                  // textColor: Colors.white,
                  onPressed: () => _confirmRegistration(context),
                ),
              ),
            ]),
      ),
    );
  }

  void _confirmRegistration(BuildContext context) async {
    try {
      await _userPoolData!.user
          .confirmRegistration(_registrationController.text);
      await showDialog<int>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('登録完了'),
            content: Text('ユーザーの登録が完了しました。'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () =>
                    Navigator.of(context).popUntil(ModalRoute.withName('/')),
              ),
            ],
          );
        },
      );
    } on CognitoClientException catch (e) {
      await showDialog<int>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('エラー'),
            content: Text(e.message as String),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(1),
              ),
            ],
          );
        },
      );
    }
  }
}

class ApiClient {
  Future<List<Product>?> getProduct(productId) async {
    final url = Uri.parse(
        'https://hausn48fya.execute-api.us-east-1.amazonaws.com/dev/productitem/postitem');

    var request = new GetProductRequest(query: 'QUERY', productId: productId);

    try {
      final response = await http.post(
          url,
          body: json.encode(request.toJson()),
          headers: {"Content-Type": "application/json"},
          {'Authorization': session.getIdToken().getJwtToken()});
      if (response.statusCode == 200) {
        final List<dynamic> body = jsonDecode(response.body);
        final List<Product> products =
            body.map((dynamic product) => Product.fromJson(product)).toList();
        return products;
      } else {
        return null;
      }
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
    return null;
  }
}

class GetProductRequest {
  final String query;
  final String productId;
  GetProductRequest({
    required this.query,
    required this.productId,
  });
  Map<String, dynamic> toJson() => {
        'OperationType': query,
        'Keys': {
          'productId': productId,
        }
      };
}
