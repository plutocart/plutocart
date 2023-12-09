import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plutocart/src/blocs/wallet_bloc/bloc/wallet_bloc.dart';
import 'package:plutocart/src/models/wallet/wallet_model.dart';
import 'package:plutocart/src/popups/action_popup.dart';

class BottomSheetDelete extends StatefulWidget {
  final Function()? listFunction;
  final int? numberPopUp1;
  final int? numberPopUp2;
  final Wallet wallet;
  const BottomSheetDelete(
      {Key? key,
      this.listFunction,
      required this.wallet,
      this.numberPopUp1,
      this.numberPopUp2})
      : super(key: key);

  @override
  _BottomSheetDeleteState createState() => _BottomSheetDeleteState();
}

class _BottomSheetDeleteState extends State<BottomSheetDelete> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20 , right: 10),
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
                        AssetImage('assets/icon/cancle_icon.png'),
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
            padding: const EdgeInsets.only(left: 20 , bottom: 16 ),
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
            padding: const EdgeInsets.only(left: 40 , right: 20 , bottom: 16),
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
            bottonSecondeNameFunction: () {
              context.read<WalletBloc>().add(DeleteWallet(1, widget.wallet.walletId! ));
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
