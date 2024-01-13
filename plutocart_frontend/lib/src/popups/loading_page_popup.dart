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
        color: Color(0xFF15616D),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoadingAnimationWidget.inkDrop(color: Colors.white, size: 150),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Text("LOADING ...",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 20,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  height: 1.0,
                ))
          ],
        ),
      );
    },
  );
}
