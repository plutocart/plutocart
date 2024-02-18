import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plutocart/src/blocs/debt_bloc/debt_bloc.dart';
import 'package:plutocart/src/blocs/goal_bloc/goal_bloc.dart';
import 'package:plutocart/src/blocs/transaction_bloc/bloc/transaction_bloc.dart';
import 'package:plutocart/src/blocs/wallet_bloc/bloc/wallet_bloc.dart';
import 'package:plutocart/src/popups/action_popup.dart';
import 'package:plutocart/src/popups/loading_page_popup.dart';

class BottomSheetDebt extends StatefulWidget {
  final int? numberPopUp1;
  final int? numberPopUp2;
  final Map<String, dynamic>? debt;
  const BottomSheetDebt(
      {Key? key, this.debt, this.numberPopUp1, this.numberPopUp2})
      : super(key: key);

  @override
  _BottomSheetDebtState createState() => _BottomSheetDebtState();
}

class _BottomSheetDebtState extends State<BottomSheetDebt> {
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
                  "You want to goal ?",
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
                  "Debt",
                  style: TextStyle(
                    color: Color(0xFF15616D),
                    fontSize: 18,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
                Text(
                  "${widget.debt!['nameDebt']}",
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
                bottonFirstName: "Cancle",
                bottonSecondeName: "Delete",
                bottonFirstNameFunction: () {
                  for (int i = 0; i < widget.numberPopUp1!; i++) {
                    Navigator.pop(context);
                  }
                },
                bottonSecondeNameFunction: () async {
                    context.read<DebtBloc>().add(DeleteDebt(widget.debt!['id']));
                       showLoadingPagePopUp(context);
                  context.read<DebtBloc>().stream.listen((state) {
                    if (state.deleteDebtStatus == DebtStatus.loaded) {
                  
                       context.read<DebtBloc>().add(GetDebtByAccountId());
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
