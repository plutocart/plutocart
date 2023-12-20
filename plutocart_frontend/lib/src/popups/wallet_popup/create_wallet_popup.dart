import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plutocart/src/blocs/wallet_bloc/bloc/wallet_bloc.dart';
import 'package:plutocart/src/popups/wallet_popup/input_field_wallet.dart';

class CreateWalletPopup extends StatefulWidget {
  const CreateWalletPopup({Key? key}) : super(key: key);

  @override
  _CreateWalletPopupState createState() => _CreateWalletPopupState();
}

class _CreateWalletPopupState extends State<CreateWalletPopup> {
  @override
  void initState() {
    context.read<WalletBloc>().add(GetAllWallet( enableOnlyStatusOnCard: true));
    super.initState();
  }
  TextEditingController _nameWalletController = new TextEditingController();
  TextEditingController _amountMoneyController = new TextEditingController();

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
                    height: 50),
              ),
              InputFieldWallet(
                lableTextField1: "Name of Wallet",
                lableTextField2: "The initial amount in your wallet",
                nameWalletController: _nameWalletController,
                amountMoneyController: _amountMoneyController,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22, right: 22, bottom: 22),
                child: ElevatedButton(
                  onPressed: () {
                    double amount = double.parse(_amountMoneyController.text);
                      context.read<WalletBloc>().add(CreateWallet(1, _nameWalletController.text, amount));
                    FocusScope.of(context).unfocus();
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(20), // Reduce the border radius
                      side: BorderSide(
                        width: 1,
                        color: Color(0xFF15616D),
                      ),
                    ),
                    minimumSize: Size(160, 42), // Set minimum button size
                    backgroundColor: Color(0xFF15616D), // Background color
                    foregroundColor: Colors.white, // Text color
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
                          height: 1.0, // Adjust the line height
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
