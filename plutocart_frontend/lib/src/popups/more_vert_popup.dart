import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plutocart/src/blocs/wallet_bloc/bloc/wallet_bloc.dart';
import 'package:plutocart/src/interfaces/slide_pop_up/slide_popup_dialog.dart';
import 'package:plutocart/src/popups/action_popup.dart';
import 'package:plutocart/src/popups/edit_wallet_popup.dart';

class MoreVertPopup extends StatefulWidget {
  const MoreVertPopup({Key? key}) : super(key: key);

  @override
  _MoreVertPopupState createState() => _MoreVertPopupState();
}

class _MoreVertPopupState extends State<MoreVertPopup> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
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
                onPressed: EditWallet,
                child: BlocBuilder<WalletBloc, WalletState>(
                  builder: (context, state) {
                    return Text(
                      "Edit",
                      style: TextStyle(
                        color: Color(0xFF15616D),
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                      ),
                    );
                  },
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
                  onPressed: () {
                    // Add your onPressed logic here
                  },
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  EditWallet() {
    showSlideDialog(
        context: context,
        child: EditWalletPopup(),
        barrierColor: Colors.white.withOpacity(0.7),
        backgroundColor: Colors.white,
        hightCard: 1.9);
  }
}
