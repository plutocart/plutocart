import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AmountTextField extends StatefulWidget {
  final String  nameField;
  final TextEditingController amountMoneyController;

  const AmountTextField({Key? key, required this.amountMoneyController , required this.nameField })
      : super(key: key);

  @override
  _AmountTextFieldState createState() => _AmountTextFieldState();
}

class _AmountTextFieldState extends State<AmountTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.amountMoneyController,
      decoration: InputDecoration(
        labelText: "${widget.nameField}",
        labelStyle: TextStyle(
          color: widget.amountMoneyController.text.isNotEmpty
              ? Color(0xFF1A9CB0)
              : Color(0XFFDD0000),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: widget.amountMoneyController.text.isNotEmpty
                ? Color(0xFF15616D)
                : Color(0XFFDD0000),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: widget.amountMoneyController.text.isNotEmpty
                ? Color(0xFF15616D)
                : Color(0XFFDD0000),
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
        color: Color(0xFF15616D),
        fontSize: 16,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
      ),
      onChanged: (value) {
        if (value.contains('.') &&
            value.indexOf('.') != value.lastIndexOf('.')) {
          // If there's more than one decimal point, remove the extra one
          widget.amountMoneyController.text =
              value.substring(0, value.lastIndexOf('.'));
        } else if (value.contains('.') &&
            value.substring(value.indexOf('.') + 1).length > 2) {
          // If there's a decimal point and more than two digits after it, limit to two digits
          widget.amountMoneyController.text =
              value.substring(0, value.indexOf('.') + 3);
        } else if (value.length == 9 && !value.contains('.')) {
          // If no decimal point and total length is 10 characters, prevent further input
          widget.amountMoneyController.text =
              value.substring(0, value.length - 1);
        }
        setState(() {});
      },
    );
  }
}
