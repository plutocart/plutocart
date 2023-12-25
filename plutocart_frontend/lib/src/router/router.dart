import 'package:flutter/material.dart';
import 'package:plutocart/src/app.dart';
import 'package:plutocart/src/pages/home/home.dart';
import 'package:plutocart/src/pages/login/home_login.dart';
import 'package:plutocart/src/pages/login/login_in_up.dart';
import 'package:plutocart/src/pages/transaction/transaction.dart';

class AppRoute{
  static const home = 'home';
  static const login = 'login';
  static const transaction = 'transaction';
  static const loginInUp = 'signUp';
  static const app = 'PlutocartApp';

 static get all => <String , WidgetBuilder>{
  home:(context) => const HomePage(),
  transaction:(context) => const TransactionPage(),
  login:(context) => const HomeLogin(),
  loginInUp:(context) => const LoginInUp(),
  app:(context) => const PlutocartApp()
 };
}