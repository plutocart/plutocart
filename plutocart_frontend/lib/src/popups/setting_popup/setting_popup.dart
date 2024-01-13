import 'package:flutter/material.dart';

class SettingPopup extends StatefulWidget {
  final String accountRole;
  const SettingPopup({Key? key, required this.accountRole}) : super(key: key);

  @override
  _SettingPopupState createState() => _SettingPopupState();
}

class _SettingPopupState extends State<SettingPopup> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Setting",
                  style: TextStyle(
                    color: Color(0xFF15616D),
                    fontSize: 24,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  )),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: ImageIcon(
                  AssetImage('assets/icon/cancel_icon.png'),
                  color: Color(0xFF15616D),
                ),
              )
            ],
          ),
        ), 
        Padding(
          padding: const EdgeInsets.only(left: 20 , right: 20 , top: 16),
          child: Row(
            children: [
              Row(
                children: [
                  Image(image: AssetImage('assets/icon/icon_launch.png') , width: MediaQuery.sizeOf(context).width * 0.1,) , 
                  Text(widget.accountRole)
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
