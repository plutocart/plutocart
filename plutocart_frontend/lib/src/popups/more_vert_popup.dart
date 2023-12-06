import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plutocart/src/blocs/wallet_bloc/bloc/wallet_bloc.dart';
import 'package:plutocart/src/interfaces/slide_pop_up/slide_popup_dialog.dart';
import 'package:plutocart/src/models/wallet/wallet_model.dart';
import 'package:plutocart/src/popups/bottom_sheet_delete.dart';
import 'package:plutocart/src/popups/wallet_popup/edit_wallet_popup.dart';

class MoreVertPopup extends StatefulWidget {
  final Function()? listFunction;
  final Wallet? wallet;
  const MoreVertPopup({Key? key, this.listFunction , this.wallet}) : super(key: key);

  @override
  _MoreVertPopupState createState() => _MoreVertPopupState();
}

class _MoreVertPopupState extends State<MoreVertPopup> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.19,
      width: 400,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15, right: 15, left: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 350,
              height: 60,
              child: ElevatedButton(
                onPressed:()=> EditWallet(widget.wallet),
                child: Text(
                  "Edit",
                  style: TextStyle(
                    color: Color(0xFF15616D),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: Color(0XFF15616D), // Border color
                      ),
                    ),
                    backgroundColor: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                  width: 350,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: ()=> buttomSheetDelete(widget.wallet!),
                    child: Text(
                      'Delete',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                            color: Color(0XFF15616D), // Border color
                          ),
                        ),
                        backgroundColor: Color(0XFFDD0000)),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  EditWallet(Wallet? wallet) {
    showSlideDialog(
        context: context,
        child: EditWalletPopup(
          numberPopUp1: 2,
          numberPopUp2: 2,
          wallet: wallet,
        ),
        barrierColor: Colors.white.withOpacity(0.7),
        backgroundColor: Colors.white,
        hightCard: 1.9);
  }

   buttomSheetDelete(Wallet wallet) {
    showSlideDialog(
        context: context,
        child: BottomSheetDelete(
          numberPopUp1: 2,
          numberPopUp2: 2,
          wallet: wallet,
          listFunction : (){
            context.read<WalletBloc>().add(DeleteWallet(1, wallet.walletId!));
             FocusScope.of(context).unfocus();
             Navigator.pop(context);
          }
        ),
        barrierColor: Colors.white.withOpacity(0.7),
        backgroundColor: Colors.white,
        hightCard: 1.6);
  }
  
}
