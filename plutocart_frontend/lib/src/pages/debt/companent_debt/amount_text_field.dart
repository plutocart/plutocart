import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AmountTextFieldGenarate extends StatefulWidget {
  final String nameField;
  final TextEditingController amountMoneyController;
  final int? calculateData;

  const AmountTextFieldGenarate(
      {Key? key,
      required this.amountMoneyController,
      required this.nameField,
      this.calculateData})
      : super(key: key);

  @override
  _AmountTextFieldGenarateState createState() =>
      _AmountTextFieldGenarateState();
}

class _AmountTextFieldGenarateState extends State<AmountTextFieldGenarate> {
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
        if (widget.calculateData! >= 0) {
          if (widget.calculateData.toString().contains('.') &&
              widget.calculateData.toString().indexOf('.') != widget.calculateData.toString().lastIndexOf('.')) {
            // If there's more than one decimal point, remove the extra one
            widget.amountMoneyController.text =
                widget.calculateData.toString().substring(0, widget.calculateData.toString().lastIndexOf('.'));
          } else if (widget.calculateData.toString().contains('.') &&
              widget.calculateData.toString().substring(widget.calculateData.toString().indexOf('.') + 1).length > 2) {
            // If there's a decimal point and more than two digits after it, limit to two digits
            widget.amountMoneyController.text =
                widget.calculateData.toString().substring(0, widget.calculateData.toString().indexOf('.') + 3);
          } else if (widget.calculateData.toString().length == 9 && !widget.calculateData.toString().contains('.')) {
            // If no decimal point and total length is 10 characters, prevent further input
            widget.amountMoneyController.text =
                widget.calculateData.toString().substring(0, widget.calculateData.toString().length - 1);
          }
        } else {
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
        }

        setState(() {});
      },
    );
  }
}
