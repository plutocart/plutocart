import 'package:flutter/material.dart';
import 'package:plutocart/src/interfaces/slide_pop_up/slide_popup_dialog.dart';
import 'package:plutocart/src/popups/transaction_popup/card_transaction_popup.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ButtonTransaction extends StatefulWidget {
  const ButtonTransaction({Key? key}) : super(key: key);

  @override
  _ButtonTransactionState createState() => _ButtonTransactionState();
}

class _ButtonTransactionState extends State<ButtonTransaction> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Skeleton.ignore(
          child: Container(
            width: MediaQuery.of(context).size.height * 0.07,
            height: MediaQuery.of(context).size.height * 0.07,
            alignment: Alignment.center,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Color(0xFF15616D),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(34.67),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    createTransactionIncome();
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
   createTransactionIncome() async {
    showSlideDialog(
        context: context,
        child:  CardTransactionPopup(),
        barrierColor: Colors.white.withOpacity(0.7),
        backgroundColor: Colors.white,
        hightCard: 2);
  }
}
