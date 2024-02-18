import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:plutocart/src/blocs/debt_bloc/debt_bloc.dart';

class CardDebtHome extends StatelessWidget {
  const CardDebtHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DebtBloc, DebtState>(
      builder: (context, state) {
        final DateTime inputDate;
        final dynamic formattedDate;
        if (state.debtList[state.debtList.length - 1]['latestPayDate'] !=
            null) {
          inputDate = DateTime.parse(
              state.debtList[state.debtList.length - 1]['latestPayDate']);
          formattedDate = DateFormat('dd MMM yyyy').format(inputDate);
        } else {
          formattedDate = null;
        }
        return Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              children: [
                Row(
                  children: [
                    Image.network(
                      'https://res.cloudinary.com/dtczkwnwt/image/upload/v1706441750/category_images/Debts_89cb0a76-a6c2-49c6-8ff3-e4a70555330d.png',
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${state.debtList[state.debtList.length - 1]['nameDebt']}",
                          style: TextStyle(
                            color: Color(0xFF15616D),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Roboto",
                          ),
                        ),
                        Text(
                          "${state.debtList[state.debtList.length - 1]['moneyLender']}",
                          style: TextStyle(
                            color: Color(0xFF707070),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Roboto",
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment : MainAxisAlignment.spaceEvenly , 
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Paid period(s)",
                                  style: TextStyle(
                                    color: Color(0xFF707070),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Roboto",
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${state.debtList[state.debtList.length - 1]['numOfPaidPeriod']}",
                                      style: TextStyle(
                                        color: Color(0XFF15616D),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Roboto",
                                      ),
                                    ),
                                    Text(
                                      "/",
                                      style: TextStyle(
                                        color: Color(0xFF707070),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Roboto",
                                      ),
                                    ),
                                    Text(
                                      "${state.debtList[state.debtList.length - 1]['payPeriod']}",
                                      style: TextStyle(
                                        color: Color(0xFF1A9CB0),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Roboto",
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 16, left: 16),
                              child: Container(
                                height: 40,
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
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
                                    color: Color(0xFF707070),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Roboto",
                                  ),
                                ),
                                Text(
                                  "${state.debtList[state.debtList.length - 1]['totalPaidDebt']}฿",
                                  style: TextStyle(
                                    color: Color(0xFF15616D),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Roboto",
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 16, left: 16),
                              child: Container(
                                height: 40,
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
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
                                    color: Color(0xFF707070),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Roboto",
                                  ),
                                ),
                                Text(
                                  "${formattedDate == null ? "-" : formattedDate}",
                                  style: TextStyle(
                                    color: Color(0xFF15616D),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Roboto",
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
