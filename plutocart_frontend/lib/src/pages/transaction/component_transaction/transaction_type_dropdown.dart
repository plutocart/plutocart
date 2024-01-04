import 'package:flutter/material.dart';

class TransactionTypeDropdown extends StatelessWidget {
  final List<Map<String, dynamic>> listTypeTransaction;
  final int indexTransactionType;
  final Function(String?) onChanged;

  const TransactionTypeDropdown({
    required this.listTypeTransaction,
    required this.indexTransactionType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: DropdownButtonFormField<String>( // Specify explicit type here (String in this case)
        decoration: InputDecoration(border: InputBorder.none),
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: Color(0xFF15616D),
        ),
        value: listTypeTransaction[indexTransactionType]['typeName'],
        style: TextStyle(color: Color(0xFF15616D)),
        dropdownColor: Color.fromARGB(255, 247, 246, 246),
        isExpanded: true,
        items: listTypeTransaction.map((value) {
          return DropdownMenuItem<String>( // Explicitly specify DropdownMenuItem<String>
            value: value['typeName'],
            child: Text(
              value['typeName'],
              style: TextStyle(
                color: Color(0xFF15616D),
                fontSize: 24,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
