import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plutocart/src/blocs/goal_bloc/goal_bloc.dart';
import 'package:plutocart/src/blocs/login_bloc/login_bloc.dart';
import 'package:plutocart/src/interfaces/slide_pop_up/slide_popup_dialog.dart';
import 'package:plutocart/src/models/goal/goal.dart';
import 'package:plutocart/src/popups/add_goal_popup/add_goal_popup.dart';
import 'package:plutocart/src/popups/setting_popup.dart';

class GoalPage extends StatefulWidget {
  const GoalPage({Key? key}) : super(key: key);

  @override
  _GoalPageState createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
  @override
  void initState() {
    context.read<GoalBloc>().add(getGoalByAccountId());
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
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16))),
                          onPressed: () {
                            createGoal();
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
                          ))
                    ],
                  ),
                ),
              ),
              BlocBuilder<GoalBloc, GoalState>(
                builder: (context, state) {
                  print("count goal : ${state.goalList!.length}");
                  return Column(
                    children: List.generate(state.goalList!.length, (index) {
                      final Map<String, dynamic> goal = state.goalList![index];
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.25,
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
                                      print("check progress : ${goal['deficit'] / goal['amountGoal']}");
                                      print("check progresss :${ goal['deficit'] / goal['amountGoal'] > 1 }");
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
                                              width:  goal['deficit'] / goal['amountGoal'] > 1 
                                              ? MediaQuery.of(context).size.width * 0.836 
                                              : goal['deficit'] / goal['amountGoal'] < 0.1 ? MediaQuery.of(context).size.width* 0.1 : MediaQuery.of(context).size.width * goal['deficit'] / goal['amountGoal'] ,
                                              height: MediaQuery.of(context) .size.height * 0.05,
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
                                        Text("0฿",
                                            style: TextStyle(
                                                color: Color(0xFF15616D),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Roboto")),
                                        Text("${goal['amountGoal']}฿",
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
                                            Text("${goal['deficit']}฿",
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
                                                "${goal['amountGoal'] - goal['deficit'] < 0 ? 0 : goal['amountGoal'] - goal['deficit'] }฿",
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

  createGoal() async {
    showSlideDialog(
        context: context,
        child: AddGoalPopup(),
        barrierColor: Colors.white.withOpacity(0.7),
        backgroundColor: Colors.white,
        hightCard: 2.5);
  }
}
