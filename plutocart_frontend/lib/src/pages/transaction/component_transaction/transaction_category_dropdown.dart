import 'package:flutter/material.dart';

class TransactionCategoryDropdown extends StatefulWidget {
  final List<dynamic> transactionCategoryList;
  final int indexTransactionCategoryType;
  final Function(int, int?) onCategoryChanged;
  final GlobalKey? selectKey;
  final String? nameCategory;
  final bool? isValue;

  const TransactionCategoryDropdown({
    Key? key,
    required this.transactionCategoryList,
    required this.indexTransactionCategoryType,
    required this.onCategoryChanged,
    this.nameCategory , 
    this.isValue ,
    this.selectKey
  }) : super(key: key);

  @override
  _TransactionCategoryDropdownState createState() =>
      _TransactionCategoryDropdownState();
}

class _TransactionCategoryDropdownState
    extends State<TransactionCategoryDropdown> {
  bool isCategorySelected = false;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      key: widget.selectKey,
      value: widget.isValue == true ? widget.nameCategory : null,
      menuMaxHeight: MediaQuery.of(context).size.height * 0.4,
      icon: Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF15616D)),
      decoration: InputDecoration(
        labelText: "Choose Transaction Category",
        labelStyle: TextStyle(
          color: isCategorySelected  || widget.isValue == true ? Color(0xFF1A9CB0) : Color(0XFFDD0000),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: isCategorySelected   || widget.isValue == true ? Color(0xFF15616D) : Color(0XFFDD0000),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(
            color: isCategorySelected  || widget.isValue == true ? Color(0xFF15616D) : Color(0XFFDD0000),
          ),
        ),
      ),
      items: widget.transactionCategoryList.map((value) {
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
        setState(() {
          int newIndex = widget.transactionCategoryList.indexWhere(
              (element) => element['nameTransactionCategory'] == newValue);
          int? newCategoryId = widget.transactionCategoryList
              .firstWhere((element) =>
                  element['nameTransactionCategory'] == newValue)['id'];
          widget.onCategoryChanged(newIndex, newCategoryId);
          isCategorySelected = true;
        });
      },
    );
  }
}
