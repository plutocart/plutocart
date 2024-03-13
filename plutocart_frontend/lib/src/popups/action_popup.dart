import 'package:flutter/material.dart';

class ActionPopup extends StatefulWidget {
  final String bottonFirstName;
  final String bottonSecondeName;
  final Function? bottonFirstNameFunction;
  final Function? bottonSecondeNameFunction;
  final bool ? isFullField;
  final bool ? isDelete;
  const ActionPopup(
      {Key? key,
      required this.bottonFirstName,
      required this.bottonSecondeName,
       this.bottonFirstNameFunction , this.bottonSecondeNameFunction , this.isFullField , this.isDelete})
      : super(key: key);

  @override
  _ActionPopupState createState() => _ActionPopupState();
}

class _ActionPopupState extends State<ActionPopup> {
  @override
  void initState() {
    widget.isFullField;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 8),
      child: Padding(
        padding: const EdgeInsets.only(left: 4, right: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //1
            ElevatedButton(
              onPressed: () => widget.bottonFirstNameFunction!(),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(16), // Reduce the border radius
                  side: BorderSide(
                    width: 1,
                    color: Color(0xFF15616D),
                  ),
                ),
                padding: EdgeInsets.zero, // Remove the default padding
                minimumSize: Size(150, 42), // Set minimum button size
                backgroundColor: Colors.white, // Background color
                foregroundColor: Color(0xFF15616D), // Text color
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.45,
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    widget.bottonFirstName,
                    style: TextStyle(
                      color: Color(0xFF15616D),
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      height: 1.0, // Adjust the line height
                    ),
                  ),
                ),
              ),
            ),
             //2
            ElevatedButton(
              onPressed: () {
                widget.bottonSecondeNameFunction!();       
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(16), // Reduce the border radius
                  side: BorderSide(
                    width: 1,
                    color: widget.isDelete == true ?  Color(0XFFDD0000) : widget.isFullField == true ? Color(0xFF15616D) : Color(0XFF898989),
                  ),
                ),
                padding: EdgeInsets.zero, // Remove the default padding
                minimumSize: Size(150, 42), // Set minimum button size
                backgroundColor:widget.isDelete == true ?  Color(0XFFDD0000) : widget.isFullField == true ? Color(0xFF15616D) : Color(0XFF898989), // Background color
                foregroundColor: widget.isDelete == true ?  Color(0XFFDD0000) : widget.isFullField == true ? Color(0xFF15616D) : Color(0XFF898989), // Text color
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width * 0.45,
                child: Center(
                  child: Text(
                    widget.bottonSecondeName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      height: 1.0, // Adjust the line height
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
