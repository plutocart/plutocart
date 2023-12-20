import 'package:flutter/material.dart';
import 'package:plutocart/src/pages/home/home.dart';
import 'package:plutocart/src/pages/login/home_login.dart';
import 'package:plutocart/src/pages/login/sign_up.dart';
import 'package:plutocart/src/pages/transaction/transaction.dart';

class AppRoute{
  static const home = 'home';
  static const login = 'login';
  static const transaction = 'transaction';
  static const signUp = 'signUp';

 static get all => <String , WidgetBuilder>{
  home:(context) => const HomePage(),
  transaction:(context) => const TransactionPage(),
  login:(context) => const HomeLogin(),
  signUp:(context) => const SignUp()
 };
}