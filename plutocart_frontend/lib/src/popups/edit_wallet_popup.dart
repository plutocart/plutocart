import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plutocart/src/blocs/wallet_bloc/bloc/wallet_bloc.dart';
import 'package:plutocart/src/pages/home/card_field.dart';
import 'package:plutocart/src/popups/action_popup.dart';

class EditWalletPopup extends StatelessWidget {
  const EditWalletPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {
        final _nameWalletController =
            TextEditingController(text: state.walletName);
        final _amountMoneyController =
            TextEditingController(text: "${state.walletBalance}");
        return 
         Container(
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Edit Wallet",
                    style: TextStyle(
                      color: Color(0xFF15616D),
                      fontSize: 24,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Container(
                width: 343,
                height: 80,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Color(0xFF15616D)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: CardField(
                  fieldController: _nameWalletController,
                  labelText: "Name of wallet",
                  inputType: TextInputType.text,
                ),
              ),
              Container(
                width: 343,
                height: 80,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Color(0xFF15616D)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: CardField(
                  fieldController: _amountMoneyController,
                  labelText: "Amount of wallet",
                  inputType: TextInputType.number,
                ),
              ),
              ActionPopup(
                bottonFirstName: "Cancel",
                bottonSecondeName: "Confirm",
              )
            ],
          ),
        );
      },
    );
  }
}
