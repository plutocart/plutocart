import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputFieldWallet extends StatefulWidget {
  final String lableTextField1;
  final String lableTextField2;
  final TextEditingController nameWalletController;
  final TextEditingController amountMoneyController;
  const InputFieldWallet(
      {Key? key,
      required this.lableTextField1,
      required this.lableTextField2,
      required this.nameWalletController,
      required this.amountMoneyController})
      : super(key: key);

  @override
  _InputFieldWalletState createState() => _InputFieldWalletState();
}

class _InputFieldWalletState extends State<InputFieldWallet> {
  @override
  Widget build(BuildContext context) {
    // double amount = double.tryParse(widget.amountMoneyController.text) ?? 0.0;

    print("check num length : ${widget.amountMoneyController.text.length}");
    print(
        "check num length : ${widget.amountMoneyController.text.length >= 0}");
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: TextField(
            maxLength: 15,
            controller: widget.nameWalletController,
            decoration: InputDecoration(
              labelText: widget.lableTextField1,
              labelStyle: TextStyle(
                color: widget.nameWalletController.text.isNotEmpty
                    ? Color(0xFF15616D)
                    : Colors.red,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: widget.nameWalletController.text.isNotEmpty
                      ? Color(0xFF15616D)
                      : Colors.red,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: widget.nameWalletController.text.isNotEmpty
                      ? Color(0xFF15616D)
                      : Colors.red,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Color(0xFF1A9CB0),
              fontSize: 18,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
            ),
            onChanged: (value) {
              setState(() {
                // Any specific logic for this TextField can go here
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: TextField(
            controller: widget.amountMoneyController,
            decoration: InputDecoration(
              labelText: widget.lableTextField2,
              labelStyle: TextStyle(
                color: widget.amountMoneyController.text.isNotEmpty
                    ? Color(0xFF15616D)
                    : Colors.red,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: widget.amountMoneyController.text.isNotEmpty
                      ? Color(0xFF15616D)
                      : Colors.red,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: widget.amountMoneyController.text.isNotEmpty
                      ? Color(0xFF15616D)
                      : Colors.red,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.deny(RegExp(r'[^\d.]')),
              LengthLimitingTextInputFormatter(13),
            ],
            style: TextStyle(
              color: Color(0xFF1A9CB0),
              fontSize: 18,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
            ),
            onChanged: (value) {
              setState(() {
                // Your validation and modification logic here
              });
            },
          ),
        ),
      ],
    );
  }
}