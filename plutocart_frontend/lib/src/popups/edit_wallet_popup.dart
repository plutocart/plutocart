import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plutocart/src/blocs/wallet_bloc/bloc/wallet_bloc.dart';
import 'package:plutocart/src/popups/action_popup.dart';

class EditWalletPopup extends StatelessWidget {
  const EditWalletPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {
        final walletBloc = context.read<WalletBloc>();
        final _nameWalletController =
            TextEditingController(text: state.walletName);
        final _amountMoneyController =
            TextEditingController(text: "${state.walletBalance}");
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
                          onPressed: () => Navigator.pop(context),
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
              Container(
                width: 343,
                height: 65,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Color(0xFF15616D)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: TextField(
                  maxLength: 20,
                  controller: _nameWalletController,
                  decoration: InputDecoration(
                      labelText: "Name of wallet", border: InputBorder.none),
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    color: Color(0xFF1A9CB0),
                    fontSize: 18,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                width: 343,
                height: 65,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Color(0xFF15616D)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: TextField(
                  maxLines: 1,
                  maxLength: 13,
                  controller: _amountMoneyController,
                  decoration: InputDecoration(
                    labelText: "Amount of wallet",
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: true, signed: false),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d{0,10}(\.\d{0,2})?$'),
                    ),
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      // ถ้ามีการลบจุดทศนิยม และเป็นการลบลบทั้งหมด
                      if (oldValue.text.contains('.') &&
                          !newValue.text.contains('.')) {
                        return TextEditingValue(
                          text: oldValue.text,
                          selection: TextSelection.collapsed(
                              offset: oldValue.text.length),
                        );
                      }
                      return newValue;
                    }),
                  ],
                  style: TextStyle(
                    color: Color(0xFF1A9CB0),
                    fontSize: 18,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              ActionPopup(
                bottonFirstName: "Cancel",
                bottonSecondeName: "Confirm",
                api: () {
                  double balanceWallet =
                      double.tryParse(_amountMoneyController.text) ?? 0.0;
                  walletBloc.add(UpdateWallet(
                      1, 1, _nameWalletController.text, balanceWallet));
                },
              )
            ],
          ),
        );
      },
    );
  }
}