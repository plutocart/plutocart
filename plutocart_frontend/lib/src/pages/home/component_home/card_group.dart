import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plutocart/src/blocs/debt_bloc/debt_bloc.dart';
import 'package:plutocart/src/blocs/goal_bloc/goal_bloc.dart';
import 'package:plutocart/src/blocs/page_bloc/page_bloc.dart';
import 'package:plutocart/src/blocs/transaction_bloc/bloc/transaction_bloc.dart';
import 'package:plutocart/src/blocs/wallet_bloc/bloc/wallet_bloc.dart';
import 'package:plutocart/src/interfaces/slide_pop_up/slide_popup_dialog.dart';
import 'package:plutocart/src/pages/home/component_home/cardDebtHome.dart';
import 'package:plutocart/src/popups/debt_popup/add_debt_popup.dart';
import 'package:plutocart/src/popups/goal_popup/add_goal_popup.dart';
import 'package:plutocart/src/popups/transaction_popup/card_transaction_popup.dart';
import 'package:plutocart/src/popups/wallet_popup/create_wallet_popup.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:intl/intl.dart';

class CardGroup extends StatefulWidget {
  final String subject;
  final String nameRoute;
  final String subjectButton;
  final Widget? widgetCard;
  final int lengthData;
  final int numberPopup;
  final int? indexPage;

  const CardGroup(String s,
      {Key? key,
      required this.subject,
      this.widgetCard,
      required this.subjectButton,
      required this.nameRoute,
      required this.lengthData,
      required this.numberPopup,
      this.indexPage})
      : super(key: key);

  @override
  _CardGroupState createState() => _CardGroupState();
}

class _CardGroupState extends State<CardGroup> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Skeleton.ignorePointer(
        child: BlocBuilder<WalletBloc, WalletState>(
          builder: (context, state) {
            return Container(
                height: widget.lengthData > 0 && widget.numberPopup == 1
                    ? widget.lengthData == 1
                        ? MediaQuery.of(context).size.height * 0.17
                        : widget.lengthData == 2
                            ? MediaQuery.of(context).size.height * 0.24
                            : MediaQuery.of(context).size.height * 0.33
                    : widget.numberPopup == 3 && widget.lengthData > 0
                        ? MediaQuery.of(context).size.height * 0.26
                        : widget.numberPopup == 4 && widget.lengthData > 0
                            ? MediaQuery.of(context).size.height * 0.19
                            : MediaQuery.of(context).size.height * 0.17,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2,
                      offset: Offset(2, 2),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: DecoratedBox(
                  decoration: ShapeDecoration(
                    color: state.status == WalletStatus.loading
                        ? Colors.grey.shade100
                        : Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1.3,
                        strokeAlign: BorderSide.strokeAlignInside,
                        color: state.status == WalletStatus.loading
                            ? Colors.white
                            : Color(0xFF15616D),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Container(
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text("${widget.subject}",
                                style: TextStyle(
                                    color: Color(0xFF15616D),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Roboto")),
                          ),
                          BlocBuilder<TransactionBloc, TransactionState>(
                            builder: (context, state) {
                              return TextButton(
                                onPressed: () {
                                  context
                                      .read<PageBloc>()
                                      .add(saveIndexPage(widget.indexPage!));
                                },
                                style: TextButton.styleFrom(
                                  shape: StadiumBorder(),
                                  foregroundColor: Colors.black,
                                ),
                                child: Row(
                                  children: [
                                    Text("more",
                                        style: TextStyle(
                                            color: Color(0xFF707070),
                                            fontSize: 14,
                                            fontFamily: "Roboto")),
                                    Icon(
                                      Icons.navigate_next,
                                      color: Color(0xFF707070),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        ],
                      ),
                      widget.lengthData > 0 && widget.numberPopup == 1
                          ? Column(
                              children: [
                                BlocBuilder<TransactionBloc, TransactionState>(
                                  builder: (context, state) {
                                    return Column(
                                      children: List.generate(
                                          state.transactionLimit3.length,
                                          (index) {
                                        final Map<String, dynamic> transaction =
                                            state.transactionLimit3[index];
                                        return Skeleton.replace(
                                          child: Container(
                                            width: 320,
                                            height: 57,
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            decoration: ShapeDecoration(
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  width: 1,
                                                  strokeAlign: BorderSide
                                                      .strokeAlignOutside,
                                                  color: Color(0xFF15616D),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image.network(
                                                        transaction[
                                                                'tranCategoryIdCategory']
                                                            ['imageIconUrl'],
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.1,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            transaction[
                                                                    'tranCategoryIdCategory']
                                                                [
                                                                'nameTransactionCategory'],
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF15616D),
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'Roboto',
                                                              height: 0,
                                                            ),
                                                          ),
                                                          Text(
                                                            transaction[
                                                                    'walletIdWallet']
                                                                ['walletName'],
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF6F6F6F),
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  'Roboto',
                                                              height: 0,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        transaction['statementType'] ==
                                                                "expense"
                                                            ? "-${NumberFormat("#,##0.00").format(transaction['stmTransaction'])}"
                                                            : "+${NumberFormat("#,##0.00").format(transaction['stmTransaction'])}",
                                                        style: TextStyle(
                                                          color: transaction[
                                                                      'statementType'] ==
                                                                  "expense"
                                                              ? Colors.red
                                                              : Color(
                                                                  0xFF2DC653),
                                                          fontSize: 16,
                                                          fontFamily: 'Roboto',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      Text(
                                                        DateFormat(
                                                                'dd MMM yyyy,HH:mm')
                                                            .format(DateTime.parse(
                                                                transaction[
                                                                    'dateTransaction'])),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                    );
                                  },
                                ),
                              ],
                            )
                          : widget.lengthData > 0 && widget.numberPopup == 3
                              ? BlocBuilder<GoalBloc, GoalState>(
                                  builder: (context, state) {
                                    final DateTime inputDate = DateTime.parse(
                                        state.goalList![state.goalList!.length -
                                            1]['endDateGoal']);
                                    final String formattedDate =
                                        DateFormat('dd MMM yyyy')
                                            .format(inputDate);
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.19,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Row(
                                                    children: [
                                                      Image(
                                                        image: AssetImage(
                                                            'assets/icon/Goals-icon.png'),
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.04,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          left: 5,
                                                        ),
                                                        child: Text(
                                                            "${state.goalList![state.goalList!.length - 1]['nameGoal']}",
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xFF15616D),
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontFamily:
                                                                    "Roboto")),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Skeleton.ignore(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    1,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.05,
                                                decoration: ShapeDecoration(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    side: BorderSide(
                                                        width: 1,
                                                        color: Colors.grey),
                                                  ),
                                                ),
                                                child: Skeleton.ignore(
                                                  child: Stack(
                                                    children: [
                                                      Positioned(
                                                        left: 0,
                                                        top: 0,
                                                        child: Container(
                                                          width: state.goalList![state.goalList!.length - 1]['deficit'] / state.goalList![state.goalList!.length - 1]['amountGoal'] >=
                                                                  1
                                                              ? MediaQuery.of(context)
                                                                      .size
                                                                      .width *
                                                                  0.84
                                                              : state.goalList![state.goalList!.length - 1]['deficit'] / state.goalList![state.goalList!.length - 1]['amountGoal'] <
                                                                      0.1
                                                                  ? MediaQuery.of(context)
                                                                          .size
                                                                          .width *
                                                                      0.1
                                                                  : state.goalList![state.goalList!.length - 1]['deficit'] / state.goalList![state.goalList!.length - 1]['amountGoal'] >
                                                                          0.8
                                                                      ? MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.8
                                                                      : MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          state.goalList![state.goalList!.length - 1]
                                                                              ['deficit'] /
                                                                          state.goalList![state.goalList!.length - 1]['amountGoal'],
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.05,
                                                          decoration:
                                                              ShapeDecoration(
                                                            color: Color(
                                                                0XFF1A9CB0),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              side: BorderSide(
                                                                  width: 1,
                                                                  color: Color(
                                                                      0XFF1A9CB0)), // Change color if needed
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10, top: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  "${((state.goalList![state.goalList!.length - 1]['deficit'] / state.goalList![state.goalList!.length - 1]['amountGoal']) * 100).abs().toStringAsFixed(0)}%",
                                                  style: TextStyle(
                                                    color: Color(0XFF707070),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Roboto",
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 2,
                                                              left: 20),
                                                      child: Text(
                                                          "${NumberFormat("#,##0.00").format(state.goalList![state.goalList!.length - 1]['deficit'])}฿",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF15616D),
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontFamily:
                                                                  "Roboto")),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 2),
                                                      child: Text("/",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF15616D),
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontFamily:
                                                                  "Roboto")),
                                                    ),
                                                    Text(
                                                        "${NumberFormat("#,##0.00").format(state.goalList![state.goalList!.length - 1]['amountGoal'])}฿",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF1A9CB0),
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontFamily:
                                                                "Roboto")),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10),
                                                  child: Row(
                                                    children: [
                                                      Text("${formattedDate}",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0XFF707070),
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontFamily:
                                                                  "Roboto")),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                )
                              : widget.lengthData > 0 && widget.numberPopup == 4
                                  ? CardDebtHome()
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Skeleton.ignore(
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.08,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1,
                                          decoration: ShapeDecoration(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  side: BorderSide(
                                                    width: 1,
                                                    strokeAlign: BorderSide
                                                        .strokeAlignOutside,
                                                    color: Color(0xFF15616D),
                                                  ))),
                                          child: BlocBuilder<WalletBloc,
                                              WalletState>(
                                            builder: (context, state) {
                                              return OutlinedButton(
                                                  style: OutlinedButton.styleFrom(
                                                      foregroundColor:
                                                          Colors.transparent,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16))),
                                                  onPressed: () {
                                                    if (widget.numberPopup ==
                                                            1 &&
                                                        state.wallets.length ==
                                                            0) {
                                                      createWallet();
                                                    } else if (widget
                                                            .numberPopup ==
                                                        1) {
                                                      createTransaction();
                                                    } else if (widget
                                                            .numberPopup ==
                                                        2) {
                                                      print("graph");
                                                    } else if (widget
                                                            .numberPopup ==
                                                        3) {
                                                      createGoal();
                                                    } else if (widget
                                                            .numberPopup ==
                                                        4) {
                                                      createDebt();
                                                    }
                                                  },
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.add,
                                                        size: 30,
                                                        color:
                                                            Color(0xFF15616D),
                                                      ),
                                                      Text(
                                                          "${widget.subjectButton}",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF15616D),
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontFamily:
                                                                  "Roboto"))
                                                    ],
                                                  ));
                                            },
                                          ),
                                        ),
                                      ),
                                    )
                    ]),
                  ),
                ));
          },
        ),
      ),
    );
  }

  createGoal() async {
    showSlideDialog(
        context: context,
        child: AddGoalPopup(),
        barrierColor: Colors.white.withOpacity(0.7),
        backgroundColor: Colors.white,
        hightCard: 2.5);
  }

   createDebt() async {
    showSlideDialog(
        context: context,
        child: AddDebtPopup(),
        barrierColor: Colors.white.withOpacity(0.7),
        backgroundColor: Colors.white,
        hightCard: 2.5);
  }

  createTransaction() async {
    showSlideDialog(
        context: context,
        child: CardTransactionPopup(),
        barrierColor: Colors.white.withOpacity(0.7),
        backgroundColor: Colors.white,
        hightCard: 2);
  }

  createWallet() async {
    showSlideDialog(
        context: context,
        child: CreateWalletPopup(),
        barrierColor: Colors.white.withOpacity(0.7),
        backgroundColor: Colors.white,
        hightCard: 2);
  }
}
