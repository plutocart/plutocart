import 'package:flutter/material.dart';

class DescriptionTextField extends StatelessWidget {
  final TextEditingController descriptionController;

  const DescriptionTextField({Key? key, required this.descriptionController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
            controller: descriptionController,
            keyboardType: TextInputType.text,
            style: TextStyle(color: Color(0xFF15616D)),
            decoration: InputDecoration(
              labelText: 'Description',
              labelStyle: TextStyle(color: Color(0XFF1A9CB0)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Color(0xFF15616D)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Color(0xFF15616D)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide(color: Color(0xFF15616D)),
              ),
            ),
          );
  }
}
