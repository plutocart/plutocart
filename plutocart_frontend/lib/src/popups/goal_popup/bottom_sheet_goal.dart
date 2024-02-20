import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plutocart/src/blocs/goal_bloc/goal_bloc.dart';
import 'package:plutocart/src/blocs/transaction_bloc/bloc/transaction_bloc.dart';
import 'package:plutocart/src/blocs/wallet_bloc/bloc/wallet_bloc.dart';
import 'package:plutocart/src/popups/action_popup.dart';
import 'package:plutocart/src/popups/loading_page_popup.dart';

class BottomSheetGoal extends StatefulWidget {
  final int? numberPopUp1;
  final int? numberPopUp2;
  final Map<String, dynamic>? goal;
  const BottomSheetGoal(
      {Key? key, this.goal, this.numberPopUp1, this.numberPopUp2})
      : super(key: key);

  @override
  _BottomSheetGoalState createState() => _BottomSheetGoalState();
}

class _BottomSheetGoalState extends State<BottomSheetGoal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "You want to delete ?",
                  style: TextStyle(
                    color: Color(0XFFDD0000),
                    fontSize: 24,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
                Material(
                  shape: CircleBorder(),
                  clipBehavior: Clip.hardEdge,
                  color: Colors.transparent,
                  child: IconButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      Navigator.pop(context);
                    },
                    icon: SizedBox(
                      child: ImageIcon(
                        AssetImage('assets/icon/cancel_icon.png'),
                      ),
                    ),
                    color: Color(0xFF15616D),
                    iconSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 16),
            child: Row(
              children: [
                Text(
                  "Details",
                  style: TextStyle(
                    color: Color(0XFF15616D),
                    fontSize: 18,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 20, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Goals",
                  style: TextStyle(
                    color: Color(0xFF15616D),
                    fontSize: 18,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
                Text(
                  "${widget.goal!['nameGoal']}",
                  style: TextStyle(
                    color: Color(0xFF15616D),
                    fontSize: 18,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 20, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Budget",
                  style: TextStyle(
                    color: Color(0xFF15616D),
                    fontSize: 18,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
                Text(
                  "${widget.goal!['amountGoal']} ฿",
                  style: TextStyle(
                    color: Color(0xFF15616D),
                    fontSize: 18,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<GoalBloc, GoalState>(
            builder: (context, state) {
              return ActionPopup(
                bottonFirstName: "Cancel",
                bottonSecondeName: "Delete",
                bottonFirstNameFunction: () {
                  for (int i = 0; i < widget.numberPopUp1!; i++) {
                    Navigator.pop(context);
                  }
                },
                bottonSecondeNameFunction: () async {
                  context
                      .read<GoalBloc>()
                      .add(DeleteGoalByGoalId(widget.goal!['id']));
                  showLoadingPagePopUp(context);
                  context.read<GoalBloc>().stream.listen((state) {
                    if (state.deleteGoalStatus == GoalStatus.loaded) {
                      context.read<WalletBloc>().add(GetAllWallet());
                      context.read<GoalBloc>().add(GetGoalByAccountId());
                       context.read<TransactionBloc>().add(GetTransactionLimit3());
                      print(
                          "check delete goal state : ${context.read<GoalBloc>().state.goalList!.length}");
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }
                  });
                },
              );
            },
          )
        ],
      ),
    );
  }
}
