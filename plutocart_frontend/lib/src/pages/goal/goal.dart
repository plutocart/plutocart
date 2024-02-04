import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:plutocart/src/blocs/goal_bloc/goal_bloc.dart';
import 'package:plutocart/src/blocs/login_bloc/login_bloc.dart';
import 'package:plutocart/src/blocs/wallet_bloc/bloc/wallet_bloc.dart';
import 'package:plutocart/src/interfaces/slide_pop_up/slide_popup_dialog.dart';
import 'package:plutocart/src/models/goal/goal.dart';
import 'package:plutocart/src/popups/goal_popup/add_goal_popup.dart';
import 'package:plutocart/src/popups/goal_popup/bottom_sheet_goal.dart';
import 'package:plutocart/src/popups/goal_popup/more_vert_goal.dart';
import 'package:plutocart/src/popups/setting_popup.dart';
import 'package:plutocart/src/popups/wallet_popup/create_wallet_popup.dart';
import 'package:plutocart/src/popups/wallet_popup/more_vert_popup_wallet.dart';
import 'dart:math' as math;

class GoalPage extends StatefulWidget {
  const GoalPage({Key? key}) : super(key: key);

  @override
  _GoalPageState createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
  @override
  void initState() {
    context.read<GoalBloc>().add(GetGoalByAccountId());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Goals",
              style: TextStyle(color: Color(0xFF15616D)),
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
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            children: [
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(width: 1, color: Colors.transparent),
                    ),
                    gradient: RadialGradient(
                      radius: 1,
                      colors: [Color(0x7AD9ED92), Color(0xB215616D)],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Image(
                              image: AssetImage('assets/icon/icon_launch.png'),
                              width: MediaQuery.of(context).size.width * 0.15,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: Image(
                              image: AssetImage('assets/icon/plus_icon.png'),
                              width: MediaQuery.of(context).size.width * 0.05,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      BlocBuilder<WalletBloc, WalletState>(
                        builder: (context, state) {
                          return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16))),
                              onPressed: () {
                                if(state.wallets.length > 0) {
                                  createGoal();
                                }
                                else{
                                  createWallet();
                                }
                              
                              },
                              child: Text(
                                'Click add your new Goal !',
                                style: TextStyle(
                                  color: Color(0xFF15616D),
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ));
                        },
                      )
                    ],
                  ),
                ),
              ),
              BlocBuilder<GoalBloc, GoalState>(
                builder: (context, state) {
                  return Column(
                    children: List.generate(state.goalList!.length, (index) {
                      final Map<String, dynamic> goal = state.goalList![index];
                      final DateTime inputDate =
                          DateTime.parse(goal['endDateGoal']);
                      final String formattedDate =
                          DateFormat('dd MMM yyyy').format(inputDate);
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.33,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(
                                    width: 1,
                                    color: Color(0XFF15616D),
                                  ))),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      "Goals",
                                      style: TextStyle(
                                          color: Color(0xFF15616D),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Roboto"),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.more_vert_outlined,
                                      color: Color(
                                          0XFF15616D), // Set the color here
                                    ),
                                    onPressed: () async {
                                      more_vert(goal['id'], goal);
                                    },
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, bottom: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text("${goal['nameGoal']}",
                                            style: TextStyle(
                                                color: Color(0xFF15616D),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Roboto")),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width * 1,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          side: BorderSide(
                                              width: 1, color: Colors.grey),
                                        ),
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            left: 0,
                                            top: 0,
                                            child: Container(
                                              width: goal['deficit'] /
                                                          goal['amountGoal'] >=
                                                      1
                                                  ? MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.836
                                                  : goal['deficit'] /
                                                              goal[
                                                                  'amountGoal'] <
                                                          0.1
                                                      ? MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.1
                                                      : goal['deficit'] /
                                                                  goal[
                                                                      'amountGoal'] >
                                                              0.8
                                                          ? MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.8
                                                          : MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              goal['deficit'] /
                                                              goal[
                                                                  'amountGoal'],
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.05,
                                              decoration: ShapeDecoration(
                                                color: Color(0XFF1A9CB0),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
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
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("0 ฿",
                                            style: TextStyle(
                                                color: Color(0xFF15616D),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Roboto")),
                                        Text("${goal['amountGoal']} ฿",
                                            style: TextStyle(
                                                color: Color(0xFF15616D),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Roboto")),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          children: [
                                            Text("Saving money",
                                                style: TextStyle(
                                                    color: Color(0xFF15616D),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Roboto")),
                                            Text("${goal['deficit']} ฿",
                                                style: TextStyle(
                                                    color: Color(0xFF2DC653),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Roboto")),
                                          ],
                                        ),
                                        Container(
                                          height: 40,
                                          decoration: ShapeDecoration(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                width: 1.5,
                                                color: Color(0xFF15616D),
                                              ),
                                              borderRadius: BorderRadius
                                                  .zero, // หรือกำหนดรูปแบบได้ตามที่ต้องการ
                                            ),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Text("Lack of Money",
                                                style: TextStyle(
                                                    color: Color(0xFF15616D),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Roboto")),
                                            Text(
                                                "${goal['amountGoal'] - goal['deficit'] < 0 ? 0 : goal['amountGoal'] - goal['deficit']} ฿",
                                                style: TextStyle(
                                                    color: Color(0xFFDD0000),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Roboto")),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text("D-day of your goal!",
                                  style: TextStyle(
                                      color: Color(0xFF15616D),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Roboto")),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    image: AssetImage(
                                        'assets/icon/party-popper.png'),
                                    height: MediaQuery.of(context).size.height *
                                        0.03,
                                  ),
                                  Text("${formattedDate}",
                                      style: TextStyle(
                                          color: Color(0xFF15616D),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Roboto")),
                                  Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.rotationY(math
                                        .pi), // Rotate 180 degrees around the X-axis
                                    child: Image(
                                      image: AssetImage(
                                          'assets/icon/party-popper.png'),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.03,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  more_vert(int goalId, Map<String, dynamic> goal) {
    showSlideDialog(
        context: context,
        child: MoreVertGoal(goal: goal, goalId: goalId),
        barrierColor: Colors.white.withOpacity(0.7),
        backgroundColor: Colors.white,
        hightCard: 1.3);
  }

  createGoal() async {
    showSlideDialog(
        context: context,
        child: AddGoalPopup(),
        barrierColor: Colors.white.withOpacity(0.7),
        backgroundColor: Colors.white,
        hightCard: 2.5);
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
