import 'package:flutter/material.dart';
import 'package:plutocart/src/models/wallet/wallet_model.dart';

class WalletDropdown extends StatelessWidget {
  final List<Wallet> walletList;
  final dynamic selectedWallet;
  final Function(String?) onChanged;

  const WalletDropdown({
    Key? key,
    required this.walletList,
    required this.selectedWallet,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      menuMaxHeight: MediaQuery.of(context).size.height * 0.4,
      icon: Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF15616D)),
      decoration: InputDecoration(
        labelText: "Choose Wallet",
        labelStyle: TextStyle(color: Color(0xFF1A9CB0)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Color(0xFF15616D)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: Color(0xFF15616D)),
        ),
      ),
      value: selectedWallet,
      items: walletList.map((wallet) {
        return DropdownMenuItem<String>(
          value: wallet.walletName,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Image(
                  image: AssetImage('assets/icon/wallet_icon.png'),
                  width: MediaQuery.sizeOf(context).width * 0.1,
                ),
              ),
              Text(
                wallet.walletName,
                style: TextStyle(
                  color: Color(0xFF15616D),
                  fontSize: 18,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
            ],
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
