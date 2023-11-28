import 'package:flutter/material.dart';

class CardField extends StatefulWidget {
  final TextEditingController fieldController;
  final String labelText;
  final TextInputType inputType;
  const CardField(
      {Key? key,
      required this.fieldController,
      required this.labelText,
      required this.inputType})
      : super(key: key);

  @override
  _CardFieldState createState() => _CardFieldState();
}

class _CardFieldState extends State<CardField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: widget.fieldController,
          decoration: InputDecoration(
            labelText: widget.labelText,
            border: InputBorder.none, // Remove the border line
          ),
          keyboardType: widget.inputType,
        )
      ],
    );
  }
}
