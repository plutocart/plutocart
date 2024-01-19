import 'package:flutter/material.dart';
import 'package:plutocart/src/interfaces/slide_pop_up/slide_popup_dialog.dart';
import 'package:plutocart/src/popups/setting_popup/setting_popup.dart';
    SettingPopUp(String accountRole , String email , BuildContext context) {
    showSlideDialog(
        context: context,
        child: SettingPopup(accountRole: accountRole , email: email,),
        barrierColor: Colors.white.withOpacity(0.7),
        backgroundColor: Colors.white,
        hightCard: 1.6);
  }