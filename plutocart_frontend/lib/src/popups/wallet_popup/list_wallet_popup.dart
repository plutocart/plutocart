import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:plutocart/src/blocs/wallet_bloc/bloc/wallet_bloc.dart';
import 'package:plutocart/src/interfaces/slide_pop_up/slide_popup_dialog.dart';
import 'package:plutocart/src/models/wallet/wallet_model.dart';
import 'package:plutocart/src/popups/wallet_popup/more_vert_popup.dart';

class ListWalletPopup extends StatefulWidget {
  const ListWalletPopup({Key? key}) : super(key: key);

  @override
  _ListWalletPopupState createState() => _ListWalletPopupState();
}

class _ListWalletPopupState extends State<ListWalletPopup> {
  @override
  void initState() {
    context.read<WalletBloc>().add(GetAllWallet());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Wallet",
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
                          Navigator.pop(context);
                        },
                        icon: SizedBox(
                          child: ImageIcon(
                            AssetImage('assets/icon/cancel_icon.png'),
                          ),
                        ),
                        color: Color(0xFF15616D),
                        iconSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            BlocBuilder<WalletBloc, WalletState>(
              builder: (context, state) {
                return Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Column(
                      children: List.generate(state.wallets.length, (index) {
                        final Wallet wallet = state.wallets[index];
                        return Container(
                          width: 320,
                          height: 57,
                          margin: const EdgeInsets.only(
                              bottom: 10), // Adjust spacing between containers
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1,
                                strokeAlign: BorderSide.strokeAlignOutside,
                                color: Color(0xFF15616D),
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image(
                                        image: AssetImage(
                                            'assets/icon/wallet_icon.png')),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 9),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${wallet.walletName.length > 12 ? "${wallet.walletName.substring(0 , 12)}..." : wallet.walletName}",
                                            style: TextStyle(
                                              color: Color(0xFF15616D),
                                              fontSize: 16,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            "${wallet.walletBalance}",
                                            style: TextStyle(
                                              color: Color(0xFF707070),
                                              fontSize: 16,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 30,
                                     
                                 
                                      child: FlutterSwitch(
                                        width: 80,
                                        value: wallet.statusWallet == 1,
                                        showOnOff: true,
                                        activeColor: Color(0XFF15616D),
                                        activeText: "Show",
                                        activeTextColor: Colors.white,
                                        activeTextFontWeight: FontWeight.w400,
                                        inactiveColor: Colors.grey,
                                        inactiveText: "No",
                                        inactiveTextColor: Colors.white,
                                        inactiveTextFontWeight: FontWeight.w400,
                                        onToggle: (bool status) {
                                          context.read<WalletBloc>().add(
                                              UpdateStatusWallet(
                                                  wallet.walletId!,
                                                  status ? 1 : 0));
                                        },
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.more_vert_outlined,
                                        color: Color(
                                            0XFF15616D), // Set the color here
                                      ),
                                      onPressed: () async {
                                        await more_vert(
                                            wallet.walletId!, wallet);

                                        context
                                            .read<WalletBloc>()
                                            .add(MapEventToState(
                                              wallet.walletId,
                                              wallet.walletName,
                                              wallet.walletBalance,
                                              wallet.statusWallet,
                                            ));
                                      },
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ));
              },
            )
          ],
        ),
      ),
    );
  }

  more_vert(int walletId, Wallet wallet) {
    showSlideDialog(
        context: context,
        child: MoreVertPopup(wallet: wallet),
        barrierColor: Colors.white.withOpacity(0.7),
        backgroundColor: Colors.white,
        hightCard: 1.3);
  }
}
