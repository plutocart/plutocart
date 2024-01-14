import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plutocart/src/blocs/wallet_bloc/bloc/wallet_bloc.dart';
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

  @override
  void initState() {
    _nameWalletController = TextEditingController();
    _nameWalletController.addListener(_onNameWalletChanged);
    _amountMoneyController.addListener(_onAmountChanged);
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
          height: MediaQuery.of(context).size.height * 0.467,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              Center(
                child: Image(
                  image: AssetImage('assets/icon/wallet_icon.png'),
                  height: 50,
                ),
              ),
              InputFieldWallet(
                lableTextField1: "Name of Wallet",
                nameWalletController: _nameWalletController,
                amountMoneyController: _amountMoneyController,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22, right: 22, bottom: 22),
                child: ElevatedButton(
                  onPressed: _isNameValid && _isAmountValid
                      ? () async {
                          double amount = double.parse(_amountMoneyController.text);
                          context.read<WalletBloc>().add(CreateWallet(_nameWalletController.text, amount));
                          showLoadingPagePopUp(context);
                          FocusScope.of(context).unfocus();
                          await Future.delayed(Duration(milliseconds: 500));
                          Navigator.pop(context);
                          Navigator.pop(context);
                          print("check data create wallet : ${_nameWalletController.text}");
                           print("check data create wallet state : ${state.wallets}");
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        width: 1,
                        color: _isNameValid && _isAmountValid
                            ? Color(0xFF15616D)
                            : Colors.transparent,
                      ),
                    ),
                    minimumSize: Size(160, 42),
                    backgroundColor: _isNameValid && _isAmountValid
                        ? Color(0xFF15616D)
                        : Colors.transparent,
                    foregroundColor: Colors.white,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: Text(
                        "Add",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                          height: 1.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }


}
