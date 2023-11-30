import 'package:flutter/material.dart';
import 'package:plutocart/src/router/router.dart';

class ActionPopup extends StatefulWidget {
  final String bottonFirstName;
  final String bottonSecondeName;
  final Function? api1;
  final Function? api2;
  const ActionPopup(
      {Key? key,
      required this.bottonFirstName,
      required this.bottonSecondeName,
       this.api1 , this.api2})
      : super(key: key);

  @override
  _ActionPopupState createState() => _ActionPopupState();
}

class _ActionPopupState extends State<ActionPopup> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 8),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //1
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(20), // Reduce the border radius
                  side: BorderSide(
                    width: 1,
                    color: Color(0xFF15616D),
                  ),
                ),
                padding: EdgeInsets.zero, // Remove the default padding
                minimumSize: Size(160, 42), // Set minimum button size
                backgroundColor: Colors.white, // Background color
                foregroundColor: Color(0xFF15616D), // Text color
              ),
              child: Container(
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
                widget.api2!();
                
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(20), // Reduce the border radius
                  side: BorderSide(
                    width: 1,
                    color: Color(0xFF15616D),
                  ),
                ),
                padding: EdgeInsets.zero, // Remove the default padding
                minimumSize: Size(160, 42), // Set minimum button size
                backgroundColor: Color(0xFF15616D), // Background color
                foregroundColor: Color(0xFF15616D), // Text color
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
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
