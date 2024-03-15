import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plutocart/src/blocs/goal_bloc/goal_bloc.dart';
import 'package:plutocart/src/blocs/transaction_bloc/bloc/transaction_bloc.dart';
import 'package:plutocart/src/blocs/wallet_bloc/bloc/wallet_bloc.dart';
import 'package:plutocart/src/interfaces/slide_pop_up/slide_popup_dialog.dart';
import 'package:plutocart/src/popups/bottom_sheet_delete.dart';
import 'package:plutocart/src/popups/goal_popup/edit_goal_popup.dart';
import 'package:plutocart/src/popups/loading_page_popup.dart';

class MoreVertGoal extends StatelessWidget {
  final Map<String, dynamic>? goal;
  final int? goalId;

  const MoreVertGoal({Key? key, this.goal = null, this.goalId = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.19,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        color: Color(0xFF15616D),
                      ))),
              onPressed: () {
                editGoal(goal!, context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.07,
                child: Center(
                  child: Text(
                    "Edit",
                    style: TextStyle(
                      color: Color(0xFF15616D),
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              )),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Color(0xFF15616D)))),
              onPressed: () {
                buttomSheetDelete(goal!, context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.07,
                child: Center(
                  child: Text(
                    "Delete",
                    style: TextStyle(
                      color: Color(0xFF15616D),
                      fontSize: 18,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  buttomSheetDelete(Map<String, dynamic> goal, BuildContext context) {
    showSlideDialog(
        context: context,
        child: BottomSheetDelete(
          numberPopUp1: 2,
          keyDetial: goal['nameGoal'],
          valueDetail: "${goal['totalGoal']}",
          bottomFunctionSecond: () {
            context.read<GoalBloc>().add(DeleteGoalByGoalId(goal['id']));
            showLoadingPagePopUp(context);
            context.read<GoalBloc>().stream.listen((state) {
              if (state.deleteGoalStatus == GoalStatus.loaded) {
                context.read<WalletBloc>().add(GetAllWallet());
                context.read<GoalBloc>().add(GetGoalByAccountId(state.statusFilterGoalNumber));
                context.read<TransactionBloc>().add(GetTransactionLimit3());
                print(
                    "check delete goal state : ${context.read<GoalBloc>().state.goalList!.length}");
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
              }
            });
          },
        ),
        barrierColor: Colors.white.withOpacity(0.7),
        backgroundColor: Colors.white,
        hightCard: 1.6);
  }

  editGoal(Map<String, dynamic> goal, BuildContext context) {
    showSlideDialog(
        context: context,
        child: EditGoalPopup(goal: goal),
        barrierColor: Colors.white.withOpacity(0.7),
        backgroundColor: Colors.white,
        hightCard: 1.9);
  }
}
