import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plutocart/src/blocs/login_bloc/login_bloc.dart';
import 'package:plutocart/src/blocs/transaction_bloc/bloc/transaction_bloc.dart';
import 'package:plutocart/src/blocs/transaction_category_bloc/bloc/transaction_category_bloc.dart';
import 'package:plutocart/src/interfaces/slide_pop_up/slide_popup_dialog.dart';
import 'package:plutocart/src/pages/home/component_home/card_group.dart';
import 'package:plutocart/src/pages/home/component_home/card_wallet.dart';
import 'package:plutocart/src/popups/setting_popup/setting_popup.dart';
import 'package:plutocart/src/router/router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<TransactionCategoryBloc>().add(GetTransactionCategoryIncome());
    context
        .read<TransactionCategoryBloc>()
        .add(GetTransactionCategoryExpense());
    context.read<TransactionBloc>().add(GetTransactionDailyInEx());
    context.read<TransactionBloc>().add(GetTransactionLimit3());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white10,
        appBar: AppBar(
          backgroundColor: Colors.white10,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  ),
                ],
              ),
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return IconButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<CircleBorder>(
                                  CircleBorder(),
                                ),
                              ),
                              splashRadius: 20,
                              onPressed: () {
                                print("check setting");
                                print("Role : ${state.accountRole}");
                                print("email : ${state.email}");
                                Setting(state.accountRole , state.email);
                              },
                              icon: Icon(Icons.settings),
                              color: Color(0xFF15616D),
                            );
                },
              )
            ],
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.27, // constrain height
                  width: MediaQuery.of(context).size.width * 1,
                  child: CardWallet(),
                ),
                BlocBuilder<TransactionBloc, TransactionState>(
                  builder: (context, state) {
                    return CardGroup(
                      "Transaction",
                      subject: 'Transactions',
                      subjectButton: 'Add A Transaction',
                      nameRoute: AppRoute.transaction,
                      lengthData: state.transactionLimit3.length,
                      numberPopup: 1,
                    );
                  },
                ),
                SizedBox(height: 6),
                CardGroup(
                  "Goals",
                  subject: 'Goals',
                  subjectButton: 'Add A Goal',
                  nameRoute: AppRoute.goal,
                  lengthData: 0,
                  numberPopup: 2,
                ),
                SizedBox(height: 6),
                CardGroup(
                  "Debts",
                  subject: 'Debts',
                  subjectButton: 'Add A Debt',
                  nameRoute: AppRoute.debt,
                  lengthData: 0,
                  numberPopup: 3,
                ),
              ],
            ),
          ),
        ));
  }
 Setting(String accountRole , String email) {
    showSlideDialog(
        context: context,
        child: SettingPopup(accountRole: accountRole , email: email,),
        barrierColor: Colors.white.withOpacity(0.7),
        backgroundColor: Colors.white,
        hightCard: 1.6);
  }
}
