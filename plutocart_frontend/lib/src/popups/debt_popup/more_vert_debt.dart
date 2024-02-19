import 'package:flutter/material.dart';
import 'package:plutocart/src/interfaces/slide_pop_up/slide_popup_dialog.dart';
import 'package:plutocart/src/popups/debt_popup/bottom_sheet_debt.dart';
import 'package:plutocart/src/popups/debt_popup/edit_debt_popup.dart';

class MoreVertDebt extends StatelessWidget {
  final Map<String, dynamic>? debt;
  final int? debtId;

  const MoreVertDebt({Key? key, this.debt = null, this.debtId = 0})
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
                  editDebt(debt! , context);
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
              onPressed: ()   {
                buttomSheetDelete(debt! , context);
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
     buttomSheetDelete(Map<String , dynamic> debt , BuildContext context) {
    showSlideDialog(
        context: context,
        child: BottomSheetDebt(
          numberPopUp1: 2,
          numberPopUp2: 2,
          debt: debt,
        ),
        barrierColor: Colors.white.withOpacity(0.7),
        backgroundColor: Colors.white,
        hightCard: 1.6);
  }


  editDebt(Map<String , dynamic> debt , BuildContext context) {
    showSlideDialog(
        context: context,
        child:
            EditDebtPopup(debt: debt),
        barrierColor: Colors.white.withOpacity(0.7),
        backgroundColor: Colors.white,
        hightCard: 3);
  }

}