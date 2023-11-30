import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plutocart/src/blocs/wallet_bloc/bloc/wallet_bloc.dart';
import 'package:plutocart/src/pages/home/component_home/card_group.dart';
import 'package:plutocart/src/pages/home/component_home/card_wallet.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white10,
      appBar: AppBar(
        backgroundColor: Colors.white10,
        title: Row(
          children: [
            Row(
              children: [
                Text(
                  "Plutocart",
                  style: TextStyle(
                    color: Color(0xFF15616D),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Roboto",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Image.asset(
                    "assets/icon/icon_launch.png",
                    width: 25,
                    height: 25,
                  ),
                )
              ],
            ),
          ],
        ),
        elevation: 0,
      ),
      body: BlocBuilder<WalletBloc, WalletState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CardWallet(),
                  SizedBox(height: 25),
                  CardGroup("Transaction", subject: 'Transactions'),
                  SizedBox(height: 16),
                  CardGroup("Goals", subject: 'Goals'),
                  SizedBox(height: 16),
                  CardGroup("Debts", subject: 'Debts'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
