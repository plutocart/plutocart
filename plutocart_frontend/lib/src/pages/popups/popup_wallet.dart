import 'package:slide_popup_dialog_null_safety/slide_popup_dialog.dart' as slideDialog;
import 'package:flutter/material.dart';


class PopupWallet extends StatefulWidget {
  const PopupWallet({ Key? key }) : super(key: key);

  @override
  _PopupWalletState createState() => _PopupWalletState();
}

class _PopupWalletState extends State<PopupWallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a wallet"),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Press to open dialog"),
          onPressed: _showDialog,
        ),
      ),
    );
  }
  void _showDialog() {
    slideDialog.showSlideDialog(
      context: context,
      child: Text("Hello World"),
      barrierColor: Colors.white.withOpacity(0.7),
      pillColor: Colors.red,
      backgroundColor: Colors.white,
      
    );
  }
}