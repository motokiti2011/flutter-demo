import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';

// final CognitoUserProvider = StreamProvider.autoDispose<Type?>((ref) {
//   // 以下のプロバイダからFirebaseAuthを取得します。
//   final cognitoAuth = ref.watch(CognitoUserSessionProvider);
//   // Stream<User?> を返すメソッドを呼び出す。
//   return cognitoAuth;
// });

// // プロバイダを使用して、cognitoにアクセスします。
// final CognitoUserSessionProvider = Provider<Type>((ref) {
//   return CognitoUserSession;
// });

final sessionProvider = StateProvider((ref) {
  return CognitoUserSession;
});

final tockenProvider = StateProvider((ref) {
  return '';
});
