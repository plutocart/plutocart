import 'package:flutter/material.dart';

class ButtonTransaction extends StatefulWidget {
  const ButtonTransaction({ Key? key }) : super(key: key);

  @override
  _ButtonTransactionState createState() => _ButtonTransactionState();
}

class _ButtonTransactionState extends State<ButtonTransaction> {
  @override
  Widget build(BuildContext context) {
    return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: MediaQuery.of(context).size.height * 0.07,
                height: MediaQuery.of(context).size.height * 0.07,
                alignment: Alignment.center,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Color(0xFF15616D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(34.67),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {print("click transaction button");},
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}