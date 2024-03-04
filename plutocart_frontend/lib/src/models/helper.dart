import 'package:flutter/material.dart';
import 'package:plutocart/src/pages/debt/debt.dart';
import 'package:plutocart/src/pages/goal/goal.dart';
import 'package:plutocart/src/pages/graph/graph.dart';
import 'package:plutocart/src/pages/home/home.dart';
import 'package:plutocart/src/pages/transaction/transaction.dart';


List<Widget> ListPage(){
  return [
    HomePage(),
    TransactionPage(),
    GraphPage(),
    GoalPage(),
    DebtPage()

  ];
}

