import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plutocart/src/blocs/transaction_bloc/bloc/transaction_bloc.dart';
import 'package:plutocart/src/interfaces/slide_pop_up/slide_popup_dialog.dart';
import 'package:plutocart/src/pages/transaction/component_transaction/edit_transaction.dart';
import 'package:plutocart/src/popups/bottom_sheet_delete.dart';
import 'package:plutocart/src/popups/loading_page_popup.dart';
class MoreVertTransaction extends StatelessWidget {
  final Map<String, dynamic>? transaction;
  final int? transactionId;

  const MoreVertTransaction({Key? key, this.transaction = null, this.transactionId = 0})
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
                 buttomSheetEdit(transaction! , context);
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
                buttomSheetDelete(transaction! , context);
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
   
      buttomSheetDelete(Map<String , dynamic> transaction , BuildContext context) {
    showSlideDialog(
        context: context,
        child: BottomSheetDelete(
          numberPopUp1: 2,
          keyDetial:  "${transaction['tranCategoryIdCategory']['nameTransactionCategory']}",
          valueDetail: "${transaction['stmTransaction']}", 
          bottomFunctionSecond: (){
              context.read<TransactionBloc>().add(DeleteTransaction(transaction['id'], transaction['walletIdWallet']['walletId']));
                         showLoadingPagePopUp(context);
                    context.read<TransactionBloc>().stream.listen((state) {
                      if (state.deleteTransactionStatus == TransactionStatus.loaded) {
                         context.read<TransactionBloc>().add(GetTransactionList());
                         context.read<TransactionBloc>().add(GetTransactionDailyInEx());
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

    buttomSheetEdit(Map<String , dynamic> transaction , BuildContext context) {
    showSlideDialog(
        context: context,
        child: EditTransaction(
          transaction: transaction,
        ),
        barrierColor: Colors.white.withOpacity(0.7),
        backgroundColor: Colors.white,
        hightCard: 2);
  }


}
