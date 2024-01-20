import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plutocart/src/blocs/transaction_bloc/bloc/transaction_bloc.dart';
import 'package:plutocart/src/blocs/wallet_bloc/bloc/wallet_bloc.dart';
import 'package:plutocart/src/models/wallet/wallet_model.dart';
import 'package:plutocart/src/popups/action_popup.dart';
import 'package:plutocart/src/popups/loading_page_popup.dart';

class BottomSheetDeleteWallet extends StatefulWidget {
  final int? numberPopUp1;
  final int? numberPopUp2;
  final Wallet wallet;
  const BottomSheetDeleteWallet(
      {Key? key, required this.wallet, this.numberPopUp1, this.numberPopUp2})
      : super(key: key);

  @override
  _BottomSheetDeleteWalletState createState() => _BottomSheetDeleteWalletState();
}

class _BottomSheetDeleteWalletState extends State<BottomSheetDeleteWallet> {
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
                  "${widget.wallet.walletName}",
                  style: TextStyle(
                    color: Color(0xFF15616D),
                    fontSize: 18,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
                Text(
                  "${widget.wallet.walletBalance} ฿",
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
          ActionPopup(
            bottonFirstName: "Cancle",
            bottonSecondeName: "Delete",
            bottonFirstNameFunction: () {
              for (int i = 0; i < widget.numberPopUp1!; i++) {
                Navigator.pop(context);
              }
            },
            bottonSecondeNameFunction: () async {
              context
                  .read<WalletBloc>()
                  .add(DeleteWallet(widget.wallet.walletId!));
              showLoadingPagePopUp(context);
              await Future.delayed(Duration(seconds: 2));
                            context.read<TransactionBloc>().add(GetTransactionLimit3());
                await Future.delayed(Duration(milliseconds: 500));              
               Navigator.pop(context);

              for (int i = 0; i < widget.numberPopUp2!; i++) {
                Navigator.pop(context);
              }
            },
          )
        ],
      ),
    );
  }
}
