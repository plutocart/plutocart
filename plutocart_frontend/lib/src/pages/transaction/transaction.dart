import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:plutocart/src/blocs/login_bloc/login_bloc.dart';
import 'package:plutocart/src/blocs/transaction_bloc/bloc/transaction_bloc.dart';
import 'package:plutocart/src/interfaces/slide_pop_up/slide_popup_dialog.dart';
import 'package:plutocart/src/pages/transaction/component_transaction/more_vert_transaction.dart';
import 'package:plutocart/src/popups/setting_popup.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  void initState() {
    context.read<TransactionBloc>().add(GetTransactionList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Transaction",
                  style: TextStyle(
                    color: Color(0xFF15616D),
                    fontSize: 24,
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
                    SettingPopUp(state.accountRole, state.email, context);
                  },
                  icon: Icon(Icons.settings),
                  color: Color(0xFF15616D),
                );
              },
            )
          ],
        ),
        backgroundColor: Colors.white10,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: BlocBuilder<TransactionBloc, TransactionState>(
            builder: (context, state) {
              return state.transactionList.length == 0
                  ? Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Center(
                      child: Container(
                          constraints: BoxConstraints(
                              minHeight: MediaQuery.of(context).size.height * 0.7),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                image: AssetImage('assets/icon/icon_launch.png'),
                                width: MediaQuery.of(context).size.width * 0.3,
                              ),
                              Text("No record",
                                  style: TextStyle(
                                      color: Color(0xFF15616D),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Roboto")),
                            ],
                          ),
                        ),
                    ),
                  )
                  : Column(
                      children:
                          List.generate(state.transactionList.length, (index) {
                      final Map<String, dynamic> transaction =
                          state.transactionList[index];
                      final DateTime inputDate =
                          DateTime.parse(transaction['dateTransaction']);
                      final String formattedDate =
                          DateFormat('dd MMM yyyy HH:mm ').format(inputDate);
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.08,
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                width: 1.5,
                                color: Color(0XFF15616D),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 0,
                                  blurRadius: 2,
                                  offset: Offset(2, 2),
                                ),
                              ],
                              color: Colors.white, // Background color
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.network(
                                        transaction['tranCategoryIdCategory']
                                            ['imageIconUrl'],
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              transaction[
                                                      'tranCategoryIdCategory']
                                                  ['nameTransactionCategory'],
                                              style: TextStyle(
                                                color: Color(0xFF15616D),
                                                fontSize: 16,
                                                fontFamily: 'Roboto',
                                                height: 0,
                                              ),
                                            ),
                                            Text(
                                              transaction['walletIdWallet']
                                                  ['walletName'],
                                              style: TextStyle(
                                                color: Color(0xFF6F6F6F),
                                                fontSize: 14,
                                                fontFamily: 'Roboto',
                                                height: 0,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "${transaction['statementType'] == "income" ? transaction['stmTransaction'].toStringAsFixed(2) : "-${transaction['stmTransaction'].toStringAsFixed(2)}"}",
                                            style: TextStyle(
                                              color: transaction[
                                                          'statementType'] ==
                                                      "income"
                                                  ? Color(0xFF2DC653)
                                                  : Color(0XFFDD0000),
                                              fontSize: 16,
                                              fontFamily: 'Roboto',
                                              height: 0,
                                            ),
                                          ),
                                          Text(
                                            "${formattedDate}",
                                            style: TextStyle(
                                              color: Color(0xFF6F6F6F),
                                              fontSize: 14,
                                              fontFamily: 'Roboto',
                                              height: 0,
                                            ),
                                          )
                                        ],
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.08,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.more_vert_outlined,
                                            color: Color(
                                                0XFF707070), // Set the color here
                                          ),
                                          onPressed: () async {
                                            more_vert(
                                                transaction['id'], transaction);
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }));
            },
          ),
        ),
      ),
    );
  }

  more_vert(int transactionId, Map<String, dynamic> transaction) {
    showSlideDialog(
        context: context,
        child: MoreVertTransaction(
            transaction: transaction, transactionId: transactionId),
        barrierColor: Colors.white.withOpacity(0.7),
        backgroundColor: Colors.white,
        hightCard: 1.3);
  }
}
