import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plutocart/src/blocs/wallet_bloc/bloc/wallet_bloc.dart';
import 'package:plutocart/src/popups/action_popup.dart';
import 'package:plutocart/src/popups/loading_page_popup.dart';
import 'package:plutocart/src/popups/wallet_popup/input_field_wallet.dart';

class CreateWalletPopup extends StatefulWidget {
  const CreateWalletPopup({Key? key}) : super(key: key);

  @override
  _CreateWalletPopupState createState() => _CreateWalletPopupState();
}

class _CreateWalletPopupState extends State<CreateWalletPopup> {
  late TextEditingController _nameWalletController;
  TextEditingController _amountMoneyController = TextEditingController();
  bool? fullField;

  void checkFullField() {
    fullField = (_nameWalletController.text.length <= 0 ||
            _amountMoneyController.text.length <= 0)
        ? false
        : true;
  }

  @override
  void initState() {
    _nameWalletController = TextEditingController();
    _nameWalletController.addListener(_onNameWalletChanged);
    _amountMoneyController.addListener(_onAmountChanged);
    _nameWalletController.addListener(() {
      setState(() {
        checkFullField();
      });
    });
    _amountMoneyController.addListener(() {
      setState(() {
        checkFullField();
      });
    });
    context.read<WalletBloc>().add(GetAllWallet(enableOnlyStatusOnCard: true));
    super.initState();
  }

  @override
  void dispose() {
    _nameWalletController.dispose();
    _amountMoneyController.dispose();
    super.dispose();
  }

  bool _isNameValid = false;
  bool _isAmountValid = false;

  void _onNameWalletChanged() {
    setState(() {
      _isNameValid = _nameWalletController.text.isNotEmpty;
    });
  }

  void _onAmountChanged() {
    setState(() {
      _isAmountValid = _amountMoneyController.text.isNotEmpty ||
          double.parse(_amountMoneyController.text) == 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.37,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Add a wallet",
                          style: TextStyle(
                            color: Color(0xFF15616D),
                            fontSize: 24,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            "Create a wallet and start saving",
                            style: TextStyle(
                              color: Color(0xFF898989),
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              InputFieldWallet(
                lableTextField1: "Name of Wallet",
                nameWalletController: _nameWalletController,
                amountMoneyController: _amountMoneyController,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: ActionPopup(
                  isFullField: fullField,
                  bottonFirstName: "Cancel",
                  bottonSecondeName: "Add",
                  bottonFirstNameFunction: () {
                    Navigator.pop(context);
                  },
                  bottonSecondeNameFunction: () async {
                    if (fullField == true) {
                      double amount = double.parse(_amountMoneyController.text);
                      context.read<WalletBloc>().add(
                          CreateWallet(_nameWalletController.text, amount));
                      showLoadingPagePopUp(context);
                      FocusScope.of(context).unfocus();
                      await Future.delayed(Duration(milliseconds: 500));
                      Navigator.pop(context);
                      Navigator.pop(context);
                      print(
                          "check data create wallet : ${_nameWalletController.text}");
                      print(
                          "check data create wallet state : ${state.wallets}");
                    }
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
