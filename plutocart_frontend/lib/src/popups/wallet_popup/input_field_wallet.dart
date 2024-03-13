import 'package:flutter/material.dart';
import 'package:plutocart/src/pages/transaction/component_transaction/amount_text_field.dart';

class InputFieldWallet extends StatefulWidget {
  final String lableTextField1;
  final TextEditingController nameWalletController;
  final TextEditingController amountMoneyController;
  const InputFieldWallet(
      {Key? key,
      required this.lableTextField1,
      required this.nameWalletController,
      required this.amountMoneyController})
      : super(key: key);

  @override
  _InputFieldWalletState createState() => _InputFieldWalletState();
}

class _InputFieldWalletState extends State<InputFieldWallet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: TextField(
            maxLength: 15,
            controller: widget.nameWalletController,
            decoration: InputDecoration(
              labelText: widget.lableTextField1,
              labelStyle: TextStyle(
                color: widget.nameWalletController.text.length != 0
                    ? Color(0xFF1A9CB0)
                    : Color(0XFFDD0000),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: widget.nameWalletController.text.length != 0
                      ? Color(0xFF15616D)
                      : Color(0XFFDD0000),
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: widget.nameWalletController.text.length != 0
                      ? Color(0xFF15616D)
                      : Color(0XFFDD0000),
                ),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Color(0xFF15616D),
              fontSize: 16,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
            ),
            onChanged: (value){
                setState(() {});
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: AmountTextField(amountMoneyController: widget.amountMoneyController, nameField: "Amount of money",)
        ),
      ],
    );
  }
}