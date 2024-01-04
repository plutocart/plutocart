import 'package:flutter/material.dart';

class TransactionCategoryDropdown extends StatelessWidget {
  final List<dynamic> transactionCategoryList;
  final int indexTransactionCategoryTypeIncome;
  final Function(int, int?) onCategoryChanged;

  const TransactionCategoryDropdown({
    Key? key,
    required this.transactionCategoryList,
    required this.indexTransactionCategoryTypeIncome,
    required this.onCategoryChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: DropdownButtonFormField(
        menuMaxHeight: MediaQuery.of(context).size.height * 0.4,
        icon: Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF15616D)),
        decoration: InputDecoration(
          labelText: "Choose Transaction Category",
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
        // value: transactionCategoryList[indexTransactionCategoryTypeIncome]
        //     ['nameTransactionCategory'],
        items: transactionCategoryList.map((value) {
          return DropdownMenuItem(
            value: value['nameTransactionCategory'],
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Image.network(
                    value['imageIconUrl'],
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                ),
                Text(
                  value['nameTransactionCategory'],
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
        onChanged: (newValue) {
          int newIndex = transactionCategoryList.indexWhere(
              (element) => element['nameTransactionCategory'] == newValue);
          int? newCategoryId = transactionCategoryList.firstWhere((element) =>
              element['nameTransactionCategory'] == newValue)['id'];
          onCategoryChanged(newIndex, newCategoryId);
        },
      ),
    );
  }
}
