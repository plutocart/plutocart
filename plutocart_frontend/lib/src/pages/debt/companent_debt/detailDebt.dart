import 'package:flutter/material.dart';

class DetailDebt extends StatelessWidget {
  final dynamic value1;
  final dynamic value2;
  const DetailDebt({Key? key, required this.value1, required this.value2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5 , bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${value1}",
            style: TextStyle(
              color: Color(0XFF898989),
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: "Roboto",
            ),
          ),
          Text(
            "${value2}",
            style: TextStyle(
              color: Color(0xFF15616D),
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: "Roboto",
            ),
          )
        ],
      ),
    );
  }
}
