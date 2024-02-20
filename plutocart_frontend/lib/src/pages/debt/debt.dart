import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:plutocart/src/blocs/debt_bloc/debt_bloc.dart';
import 'package:plutocart/src/blocs/login_bloc/login_bloc.dart';
import 'package:plutocart/src/interfaces/slide_pop_up/slide_popup_dialog.dart';
import 'package:plutocart/src/pages/debt/companent_debt/detailDebt.dart';
import 'package:plutocart/src/popups/debt_popup/add_debt_popup.dart';
import 'package:plutocart/src/popups/debt_popup/more_vert_debt.dart';
import 'package:plutocart/src/popups/setting_popup.dart';

class DebtPage extends StatefulWidget {
  const DebtPage({Key? key}) : super(key: key);

  @override
  _DebtPageState createState() => _DebtPageState();
}

class _DebtPageState extends State<DebtPage> {
  List<bool> statusCard = [];
  @override
  void initState() {
    context.read<DebtBloc>().add(GetDebtByAccountId());
    BlocProvider.of<DebtBloc>(context).state.debtList.forEach((_) {
      statusCard.add(false);
    });
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
                  "Debts",
                  style: TextStyle(
                    color: Color(0xFF15616D),
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Roboto",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5 ,),
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
                return Row(
                  children: [
                    IconButton(
                        alignment: Alignment.centerRight,
                        splashRadius: 5,
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<CircleBorder>(
                            CircleBorder(),
                          ),
                        ),
                        onPressed: () async {
                           createDebt();
                          context.read<DebtBloc>().stream.listen((event) {
                            statusCard = []; // Clear the list

                            context.read<DebtBloc>().add(GetDebtByAccountId());
                            BlocProvider.of<DebtBloc>(context)
                                .state
                                .debtList
                                .forEach((_) {
                              statusCard.add(
                                  false); // Populate the list again if needed
                            });
                          });
                        },
                        icon: Image.asset(
                          'assets/icon/plus_icon.png',
                          width: 20,
                        )),
                    IconButton(
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
                    ),
                  ],
                );
              },
            )
          ],
        ),
        backgroundColor: Colors.white10,
        elevation: 0,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: BlocBuilder<DebtBloc, DebtState>(
              builder: (context, state) {
                return state.debtList.length == 0
                    ? Center(
                        child: Container(
                          constraints: BoxConstraints(
                              minHeight:
                                  MediaQuery.of(context).size.height * 0.8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                image:
                                    AssetImage('assets/icon/icon_launch.png'),
                                width: MediaQuery.of(context).size.width * 0.3,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 79),
                                child: Text("No record",
                                    style: TextStyle(
                                        color: Color(0xFF15616D),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Roboto")),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Column(
                        children: List.generate(state.debtList.length, (index) {
                          final Map<String, dynamic> debt =
                              state.debtList[index];
                          final DateTime inputDate;
                          final dynamic formattedDate;
                          if (debt['latestPayDate'] != null) {
                            inputDate = DateTime.parse(debt['latestPayDate']);
                            formattedDate =
                                DateFormat('dd MMM yyyy').format(inputDate);
                          } else {
                            formattedDate = null;
                          }

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: OutlinedButton(
                              style: ButtonStyle(
                                side: MaterialStateProperty.all<BorderSide>(
                                    BorderSide.none),
                                overlayColor: MaterialStateProperty.all<Color>(
                                    Colors.white),
                              ),
                              onPressed: () {
                                statusCard[index] = !statusCard[index];
                                setState(() {});
                              },
                              child: Center(
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height: statusCard[index] == true
                                      ? MediaQuery.of(context).size.height *
                                          0.38
                                      : MediaQuery.of(context).size.height *
                                          0.15,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      width: 1.5,
                                      color: Color(0XFF15616D),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(
                                            0.2), 
                                        spreadRadius: 0, 
                                        blurRadius: 2, 
                                        offset: Offset(2,
                                            2), 
                                      ),
                                    ],
                                    color: Colors.white, // Background color
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, top: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Image.network(
                                                  'https://res.cloudinary.com/dtczkwnwt/image/upload/v1706441750/category_images/Debts_89cb0a76-a6c2-49c6-8ff3-e4a70555330d.png',
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.1,
                                                ),
                                                SizedBox(width: 10),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${debt['nameDebt']}",
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF15616D),
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontFamily: "Roboto",
                                                      ),
                                                    ),
                                                    Text(
                                                      "${debt['moneyLender']}",
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF707070),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontFamily: "Roboto",
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.08,
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.more_vert_outlined,
                                                  color: Color(
                                                      0XFF707070), // Set the color here
                                                ),
                                                onPressed: () async {
                                                  more_vert(debt['id'], debt);
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        statusCard[index] == true
                                            ? Column(
                                                children: [
                                                  Container(
                                                    height: 2,
                                                    decoration: ShapeDecoration(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        side: BorderSide(
                                                          width: 1,
                                                          color:
                                                              Color(0X89707070),
                                                        ),
                                                        borderRadius: BorderRadius
                                                            .zero, // หรือกำหนดรูปแบบได้ตามที่ต้องการ
                                                      ),
                                                    ),
                                                  ),
                                                  DetailDebt(
                                                    value1: "Total periods",
                                                    value2: debt['payPeriod'],
                                                  ),
                                                  DetailDebt(
                                                    value1: "Paid period(s)",
                                                    value2:
                                                        debt['numOfPaidPeriod'],
                                                  ),
                                                  DetailDebt(
                                                    value1: "Monthly payment",
                                                    value2: NumberFormat("##,##0.00").format(debt[
                                                        'paidDebtPerPeriod'],), 
                                                  ),
                                                  DetailDebt(
                                                    value1: "Debt paid",
                                                    value2:
                                                        NumberFormat("##,##0.00").format(debt['totalPaidDebt']),
                                                  ),
                                                  DetailDebt(
                                                    value1: "Total debt",
                                                    value2: NumberFormat("##,##0.00").format(debt['amountDebt']),
                                                  ),
                                                  DetailDebt(
                                                    value1: "Latest paid",
                                                    value2:
                                                        "${formattedDate == null ? "-" : formattedDate}",
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.9,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.055,
                                                      child: ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  backgroundColor:
                                                                      Color(
                                                                          0XFF15616D),
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                  )),
                                                          onPressed: () {},
                                                          child:
                                                              Text("Complete")),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                        "Paid period(s)",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF707070),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily: "Roboto",
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "${debt['numOfPaidPeriod']}",
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0XFF15616D),
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontFamily:
                                                                  "Roboto",
                                                            ),
                                                          ),
                                                          Text(
                                                            "/",
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF707070),
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontFamily:
                                                                  "Roboto",
                                                            ),
                                                          ),
                                                          Text(
                                                            "${debt['payPeriod']}",
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF1A9CB0),
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontFamily:
                                                                  "Roboto",
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10,
                                                            left: 10),
                                                    child: Container(
                                                      height: 40,
                                                      decoration:
                                                          ShapeDecoration(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          side: BorderSide(
                                                            width: 1,
                                                            color: Colors.grey,
                                                          ),
                                                          borderRadius: BorderRadius
                                                              .zero, // หรือกำหนดรูปแบบได้ตามที่ต้องการ
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        "Debt paid",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF707070),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily: "Roboto",
                                                        ),
                                                      ),
                                                      Text(
                                                        "${NumberFormat("#,##0.00").format(debt['totalPaidDebt'])}฿",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF15616D),
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily: "Roboto",
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10,
                                                            left: 10),
                                                    child: Container(
                                                      height: 40,
                                                      decoration:
                                                          ShapeDecoration(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          side: BorderSide(
                                                            width: 1,
                                                            color: Colors.grey,
                                                          ),
                                                          borderRadius: BorderRadius
                                                              .zero, // หรือกำหนดรูปแบบได้ตามที่ต้องการ
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        "Latest paid",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF707070),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily: "Roboto",
                                                        ),
                                                      ),
                                                      Text(
                                                        "${formattedDate == null ? "-" : formattedDate}",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF15616D),
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily: "Roboto",
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      );
              },
            ),
          ),
        ),
      ),
    );
  }

  createDebt() async {
    showSlideDialog(
        context: context,
        child: AddDebtPopup(),
        barrierColor: Colors.white.withOpacity(0.7),
        backgroundColor: Colors.white,
        hightCard: 3);
  }

  more_vert(int debtId, Map<String, dynamic> debt) {
    showSlideDialog(
        context: context,
        child: MoreVertDebt(debt: debt, debtId: debtId),
        barrierColor: Colors.white.withOpacity(0.7),
        backgroundColor: Colors.white,
        hightCard: 1.3);
  }
}
