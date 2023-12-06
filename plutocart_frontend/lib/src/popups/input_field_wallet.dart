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
                color: Color(0xFF15616D), // Change the label text color to red
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 2,
                    color:
                        Color(0xFF15616D)), // Change border color when active
                borderRadius: BorderRadius.circular(16),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1,
                    color: Color(0xFF15616D)), // Border color when inactive
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
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: TextField(
            controller: widget.amountMoneyController,
            decoration: InputDecoration(
              labelText: widget.lableTextField2,
              labelStyle: TextStyle(
                color: Color(0xFF15616D), // เปลี่ยนสีข้อความ label เป็นสีแดง
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Color(0xFF15616D), // เปลี่ยนสีขอบเมื่อเป็นสถานะ active
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color:
                      Color(0xFF15616D), // เปลี่ยนสีขอบเมื่อเป็นสถานะ inactive
                ),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            keyboardType: TextInputType.numberWithOptions(
                decimal: true), // กำหนดให้รับค่าตัวเลขและทศนิยม
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.deny(RegExp(
                  r'[^\d.]')), // ไม่ยอมให้ป้อนตัวอักษรที่ไม่ใช่ตัวเลขหรือจุดทศนิยม
              LengthLimitingTextInputFormatter(13),
            ],
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
              } else if (value.length == 10 && !value.contains('.')) {
                // If no decimal point and total length is 10 characters, prevent further input
                widget.amountMoneyController.text =
                    value.substring(0, value.length - 1);
              }
            },
            style: TextStyle(
              color: Color(0xFF1A9CB0),
              fontSize: 18,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
