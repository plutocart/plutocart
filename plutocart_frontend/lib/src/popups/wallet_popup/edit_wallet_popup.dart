import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plutocart/src/blocs/wallet_bloc/bloc/wallet_bloc.dart';
import 'package:plutocart/src/models/wallet/wallet_model.dart';
import 'package:plutocart/src/popups/action_popup.dart';
import 'package:plutocart/src/popups/wallet_popup/input_field_wallet.dart';

class EditWalletPopup extends StatefulWidget {
  final int? numberPopUp1;
  final int? numberPopUp2;
  final Wallet? wallet;
  const EditWalletPopup(
      {Key? key, this.numberPopUp1, this.numberPopUp2, this.wallet})
      : super(key: key);

  @override
  State<EditWalletPopup> createState() => _EditWalletPopupState();
}

class _EditWalletPopupState extends State<EditWalletPopup> {
  TextEditingController _nameWalletController = new TextEditingController();
  TextEditingController _amountMoneyController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.wallet?.walletName != null &&
        widget.wallet?.walletBalance != null) {
      _nameWalletController.text = widget.wallet!.walletName.length > 0
          ? widget.wallet!.walletName
          : "Unknow Wallet";
      _amountMoneyController =
          TextEditingController(text: "${widget.wallet!.walletBalance}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Edit Wallet",
                  style: TextStyle(
                    color: Color(0xFF15616D),
                    fontSize: 24,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Material(
                    shape: CircleBorder(),
                    clipBehavior: Clip.hardEdge,
                    color: Colors.transparent,
                    child: IconButton(
                      onPressed: () {
                         FocusScope.of(context).unfocus();
                        Navigator.pop(context);},
                      icon: SizedBox(
                        child: ImageIcon(
                          AssetImage('assets/icon/cancle_icon.png'),
                        ),
                      ),
                      color: Color(0xFF15616D),
                      iconSize: 20,
                    ),
                  ),
                )
              ],
            ),
          ),
          InputFieldWallet(
            lableTextField1: "Name of wallet",
            lableTextField2: "Amount of wallet",
            nameWalletController: _nameWalletController,
            amountMoneyController: _amountMoneyController,
          ),

          ActionPopup(
            bottonFirstName: "Cancel",
            bottonSecondeName: "Confirm",
            bottonFirstNameFunction: () {
              for (int i = 0; i < widget.numberPopUp1!; i++) {
                FocusScope.of(context).unfocus();
                Navigator.pop(context);
              }
            },
            bottonSecondeNameFunction: () {
              double balanceWallet =
                  double.tryParse(_amountMoneyController.text) ?? 0.0;
              context.read<WalletBloc>().add(UpdateWallet(
                  1,
                  widget.wallet?.walletId ?? 0,
                  _nameWalletController.text,
                  balanceWallet));
              for (int i = 0; i < widget.numberPopUp2!; i++) {
                FocusScope.of(context).unfocus();
                Navigator.pop(context);
              }
            },
          )
        ],
      ),
    );
  }
}
