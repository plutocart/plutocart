import 'package:flutter/material.dart';
import 'package:plutocart/src/popups/action_popup.dart';

class BottomSheetDelete extends StatefulWidget {
  final int? numberPopUp1;
  final String ? keyDetial;
  final String ? valueDetail;
  final Function ? bottomFunctionSecond;
  const BottomSheetDelete(
      {Key? key, required this.keyDetial, required this.valueDetail , required this.bottomFunctionSecond ,  this.numberPopUp1,})
      : super(key: key);

  @override
  _BottomSheetDeleteState createState() =>
      _BottomSheetDeleteState();
}

class _BottomSheetDeleteState extends State<BottomSheetDelete> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Image(
              image: AssetImage('assets/icon/remove_icon.png'),
              height: MediaQuery.of(context).size.height * 0.06,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      "Are you sure to delete",
                      style: TextStyle(
                        color: Color(0XFF15616D),
                        fontSize: 24,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                    Text(
                      "Wallet ?",
                      style: TextStyle(
                        color: Color(0XFF15616D),
                        fontSize: 24,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 40,
              right: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${widget.keyDetial}",
                  style: TextStyle(
                    color: Color(0xFF15616D),
                    fontSize: 18,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
                Text(
                  "${widget.valueDetail} ฿",
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
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: ActionPopup(
              isDelete: true,
              bottonFirstName: "Cancel",
              bottonSecondeName: "Delete",
              bottonFirstNameFunction: () {
                for (int i = 0; i < widget.numberPopUp1!; i++) {
                  Navigator.pop(context);
                }
              },
              bottonSecondeNameFunction: () async {
                widget.bottomFunctionSecond!();
              },
            ),
          )
        ],
      ),
    );
  }
}
