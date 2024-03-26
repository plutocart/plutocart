import 'package:flutter/material.dart';
import 'package:plutocart/src/popups/action_popup.dart';

class ActionCompletePopup extends StatefulWidget {
  final String nameAction;
  final Image imageIcon;
  final Function buttonFuction2;
  final String keyname;
  final String value;

  const ActionCompletePopup(
      {Key? key,
      required this.nameAction,
      required this.imageIcon,
      required this.buttonFuction2,
      required this.keyname,
      required this.value})
      : super(key: key);

  @override
  _ActionCompletePopupState createState() => _ActionCompletePopupState();
}

class _ActionCompletePopupState extends State<ActionCompletePopup> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.34,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(child: widget.imageIcon),
          Column(
            children: [
              Text(
                "${widget.nameAction}",
                style: TextStyle(
                  color: Color(0XFF15616D),
                  fontSize: 24,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
              Text(
                "Complete!",
                style: TextStyle(
                  color: Color(0XFF15616D),
                  fontSize: 24,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${widget.keyname}",
                        style: TextStyle(
                          color: Color(0XFF15616D),
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                      Text(
                        "${widget.value}",
                        style: TextStyle(
                          color: Color(0XFF15616D),
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      )
                    ],
                  ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: ActionPopup(
              isFullField: true,
              bottonFirstName: "Cancel",
              bottonSecondeName: "Complete",
              bottonFirstNameFunction: () {
                Navigator.pop(context);
              },
              bottonSecondeNameFunction: () async {
                widget.buttonFuction2();
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
