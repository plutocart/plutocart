import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

void showLoadingPagePopUp(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // ไม่ให้ปิดได้โดยการแตะภายนอก Dialog
    builder: (BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width * 1,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Plutocart",
                    style: TextStyle(
                      color: Color(0xFF15616D),
                      fontSize: 30,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      height: 1.0,
                    )),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Image(image: AssetImage('assets/icon/icon_launch.png') , height: MediaQuery.of(context).size.height * 0.05,
                     ),
                    )
              ],
            ) , 
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
             LoadingAnimationWidget.inkDrop(color: Color(0xFF15616D), size: 40),
           
          ],
        ),
      );
    },
  );
}
