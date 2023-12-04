import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plutocart/src/blocs/wallet_bloc/bloc/wallet_bloc.dart';
import 'package:plutocart/src/models/wallet/wallet_model.dart';
import 'package:plutocart/src/popups/action_popup.dart';

class EditWalletPopup extends StatefulWidget {
  final int? numberPopUp1;
  final int? numberPopUp2;
  final Wallet? wallet;
  const EditWalletPopup(
      {Key? key, this.numberPopUp1, this.numberPopUp2, this.wallet})
      : super(key: key);

  @override
  State<EditWalletPopup> createState() => _EditWalletPopupState();
}

class _EditWalletPopupState extends State<EditWalletPopup> {
  TextEditingController _nameWalletController = new TextEditingController();
  TextEditingController _amountMoneyController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.wallet?.walletName != null &&
        widget.wallet?.walletBalance != null) {
      _nameWalletController.text = widget.wallet!.walletName.length > 0
          ? widget.wallet!.walletName
          : "Unknow Wallet";
      _amountMoneyController =
          TextEditingController(text: "${widget.wallet!.walletBalance}");
    }
  }

  @override
  Widget build(BuildContext context) {
    print("ddd : ${_amountMoneyController}");
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Edit Wallet",
                  style: TextStyle(
                    color: Color(0xFF15616D),
                    fontSize: 24,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Material(
                    shape: CircleBorder(),
                    clipBehavior: Clip.hardEdge,
                    color: Colors.transparent,
                    child: IconButton(
                      onPressed: () {
                         FocusScope.of(context).unfocus();
                        Navigator.pop(context);},
                      icon: SizedBox(
                        child: ImageIcon(
                          AssetImage('assets/icon/cancle_icon.png'),
                        ),
                      ),
                      color: Color(0xFF15616D),
                      iconSize: 20,
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              controller: _nameWalletController,
              decoration: InputDecoration(
                labelText: "Name of wallet",
                labelStyle: TextStyle(
                  color:
                      Color(0xFF15616D), // Change the label text color to red
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 2,
                      color:
                          Color(0xFF15616D)), // Change border color when active
                  borderRadius: BorderRadius.circular(16),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1,
                      color: Color(0xFF15616D)), // Border color when inactive
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              keyboardType: TextInputType.text,
              style: TextStyle(
                color: Color(0xFF1A9CB0),
                fontSize: 18,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
         Padding(
  padding: const EdgeInsets.only(left: 20, right: 20),
  child: TextField(
    controller: _amountMoneyController,
    decoration: InputDecoration(
      labelText: "Amount of wallet",
      labelStyle: TextStyle(
        color: Color(0xFF15616D), // เปลี่ยนสีข้อความ label เป็นสีแดง
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: Color(0xFF15616D), // เปลี่ยนสีขอบเมื่อเป็นสถานะ active
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: Color(0xFF15616D), // เปลี่ยนสีขอบเมื่อเป็นสถานะ inactive
        ),
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    keyboardType: TextInputType.numberWithOptions(decimal: true), // กำหนดให้รับค่าตัวเลขและทศนิยม
    inputFormatters: <TextInputFormatter>[
      FilteringTextInputFormatter.deny(RegExp(r'[^\d.]')), // ไม่ยอมให้ป้อนตัวอักษรที่ไม่ใช่ตัวเลขหรือจุดทศนิยม
      LengthLimitingTextInputFormatter(13),
    ],
    onChanged: (value) {
      if (value.contains('.') && value.substring(value.indexOf('.') + 1).length > 2) {
        // ถ้ามีจุดทศนิยมและมีตัวเลขหลังจุดทศนิยมเกิน 2 ตำแหน่ง
        _amountMoneyController.text = value.substring(0, value.indexOf('.') + 3);
        // ให้เซ็ตค่า TextField เป็นค่าที่มีทศนิยมไม่เกิน 2 ตำแหน่ง
      } else if (value.length == 10 && !value.contains('.')) {
        // ถ้ายังไม่มีจุดทศนิยมและตำแหน่งทั้งหมดเต็ม 10 ตัว
        _amountMoneyController.text = value.substring(0, value.length - 1);
        // ให้ไม่ลบตัวเลขที่เพิ่มเติมเมื่อถึงตำแหน่งที่ 10
      }
    },
    style: TextStyle(
      color: Color(0xFF1A9CB0),
      fontSize: 18,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,
    ),
  ),
),

          ActionPopup(
            bottonFirstName: "Cancel",
            bottonSecondeName: "Confirm",
            bottonFirstNameFunction: () {
              for (int i = 0; i < widget.numberPopUp1!; i++) {
                FocusScope.of(context).unfocus();
                Navigator.pop(context);
              }
            },
            bottonSecondeNameFunction: () {
              double balanceWallet =
                  double.tryParse(_amountMoneyController.text) ?? 0.0;
              context.read<WalletBloc>().add(UpdateWallet(
                  1,
                  widget.wallet?.walletId ?? 0,
                  _nameWalletController.text,
                  balanceWallet));
              for (int i = 0; i < widget.numberPopUp2!; i++) {
                FocusScope.of(context).unfocus();
                Navigator.pop(context);
              }
            },
          )
        ],
      ),
    );
  }
}
