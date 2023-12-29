import 'dart:math';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plutocart/src/blocs/wallet_bloc/bloc/wallet_bloc.dart';
import 'package:plutocart/src/interfaces/slide_pop_up/slide_popup_dialog.dart';
import 'package:plutocart/src/models/wallet/wallet_model.dart';
import 'package:plutocart/src/popups/wallet_popup/create_wallet_popup.dart';
import 'package:plutocart/src/popups/wallet_popup/edit_wallet_popup.dart';
import 'package:plutocart/src/popups/wallet_popup/list_wallet_popup.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CardWallet extends StatefulWidget {
  const CardWallet({Key? key}) : super(key: key);

  @override
  _CardWalletState createState() => _CardWalletState();
}

class _CardWalletState extends State<CardWallet> {
  bool isClicked = false; // Track button click

  @override
  void initState() {
    context.read<WalletBloc>().add(GetAllWallet());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {
        final List<Wallet> removeStatusOff =
            state.wallets.where((e) => e.statusWallet == 1).toList();
        return Skeleton.ignorePointer(
          child: Swiper(
            index:  state.currentColossalIndex,
            onIndexChanged: (index)=> context.read<WalletBloc>().add(OnIndexChanged(index)) ,
            itemBuilder: (BuildContext context, int index) {
              if (index == removeStatusOff.length ||
                  removeStatusOff.length == 0) {
                return Container(
                  child: FractionallySizedBox(
                    heightFactor: 0.7,
                    widthFactor: 0.98,
                    child: Container(
                      decoration: BoxDecoration(
                        color: state.status == WalletStatus.loading ? Colors.white : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2,
                            offset: Offset(2, 2),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: state.wallets.length < 6 ? 10 : 10, top: 10),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  state.wallets.length < 6
                                      ? Image(
                                          image: AssetImage(
                                              'assets/icon/plus_icon.png'),
                                          height: 30,
                                        )
                                      : Transform.rotate(
                                          angle: 45 * 3.141592653589793 / 180,
                                          child: Image(
                                            image: AssetImage(
                                                'assets/icon/plus_icon.png'),
                                            height: 30, color:Color(0x5015616D),
                                          ),
                                        ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  ElevatedButton(
                                    onPressed: state.wallets.length < 6
                                        ? () async {
                                            await createWallet();
                                            context.read<WalletBloc>().add(
                                                GetAllWallet(
                                                    enableOnlyStatusOnCard:
                                                        true));
                                          }
                                        : null,
                                    child: state.wallets.length < 6
                                        ? Text("Add new wallet")
                                        : Text("Wallet is full"),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:state.status == WalletStatus.loading ? Colors.white : Colors.grey.shade100,
                                      foregroundColor: Color(0xFF15616D),
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                        width: 1, color: state.status == WalletStatus.loading ? Colors.white  : Colors.grey.shade400),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ).copyWith(
                                      overlayColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                          if (states.contains(
                                                  MaterialState.hovered) &&
                                              state.wallets.length < 6) {
                                            return Colors.transparent;
                                          }
                                          return Color(0x4015616D);
                                        },
                                      ),
                                    ),
                                  )
                                ]),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Skeleton.ignore(
                                child: Container(
                                  height: 100,
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 1.5,
                                        color: Color(0xFF15616D),
                                      ),
                                      borderRadius: BorderRadius.zero,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: state.wallets.length < 6 ? 30 : 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  image:
                                      AssetImage('assets/icon/icon_launch.png'),
                                  height: 40,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                    onPressed: () async {
                                      await showWallets();
                                      context.read<WalletBloc>().add(GetAllWallet(
                                          
                                          enableOnlyStatusOnCard: true));
                                    },
                                    child: Text("Your wallets"),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: state.status == WalletStatus.loading ? Colors.white : Colors.grey.shade100,
                                      foregroundColor: Color(0xFF15616D),
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            width: 1, color: state.status == WalletStatus.loading ? Colors.white  : Colors.grey.shade400),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                Wallet wallet = removeStatusOff[index];
                return Container(
                    child: TextButton(
                  onPressed: () async {
                    await showWallets();
                    context
                        .read<WalletBloc>()
                        .add(GetAllWallet( enableOnlyStatusOnCard: true));
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 1,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2,
                          offset: Offset(2, 2),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Container(
                      child: Column(children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    wallet.walletName.length > 12
                                        ? "${wallet.walletName.substring(0, 12)}..."
                                        : wallet.walletName,
                                    style: TextStyle(
                                        color: Color(0xFF15616D),
                                        fontSize: 14,
                                        fontFamily: "Roboto",
                                        fontWeight: FontWeight.w500),
                                  )),
                              Material(
                                shape: CircleBorder(),
                                clipBehavior: Clip.hardEdge,
                                color: Colors.transparent,
                                child: Ink(
                                  child: IconButton(
                                    onPressed: () => editWallet(wallet),
                                    icon: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: ImageIcon(
                                        AssetImage('assets/icon/edit_icon.png'),
                                      ),
                                    ),
                                    color: Color(0XFF15616D), // ตั้งค่าสีไอคอน
                                    iconSize: 20, // ตั้งค่าขนาดไอคอน
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BlocBuilder<WalletBloc, WalletState>(
                                builder: (context, state) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(width: 32),
                                      Text(
                                        wallet.walletBalance.toString(),
                                        style: TextStyle(
                                            color: Color(0xFF15616D),
                                            fontSize: 25,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Roboto"),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 15),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 3),
                                          child: Text(
                                            "฿",
                                            style: TextStyle(
                                                color: Color(0xFF15616D),
                                                fontSize: 25,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Roboto"),
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "Daily expense",
                                        style: TextStyle(
                                            color: Color(0xFF15616D),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Roboto'),
                                      ),
                                      Text("-0 ฿",
                                          style: TextStyle(
                                              color: Color(0xFFDD0000),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Roboto')),
                                    ],
                                  ),
                                  Skeleton.ignore(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 25),
                                      child: Container(
                                        height: 40,
                                        decoration: ShapeDecoration(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                              width: 1.5,
                                              color: Color(0xFF15616D),
                                            ),
                                            borderRadius: BorderRadius
                                                .zero, // หรือกำหนดรูปแบบได้ตามที่ต้องการ
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 0,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                          color: Color(0xFF15616D),
                                          width: 3.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Daily income",
                                        style: TextStyle(
                                            color: Color(0xFF15616D),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Roboto'),
                                      ),
                                      Text("0 ฿",
                                          style: TextStyle(
                                              color: Color(0xFF2DC653),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Roboto')),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ),
                ));
              }
            },
            itemCount: removeStatusOff.length + 1,
            controller: context.read<WalletBloc>().swiperController,
            viewportFraction: 1,
            scale: 0.9,
            loop: true,
            pagination: SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                space: 2,
                color: Colors.grey.shade300,
                activeColor: Color(0XFF15616D),
              ),
              margin: EdgeInsets.all(5.0),
            ),
          ),
        );
      },
    );
  }

  editWallet(Wallet? wallet) {
    showSlideDialog(
        context: context,
        child:
            EditWalletPopup(numberPopUp1: 1, numberPopUp2: 1, wallet: wallet),
        barrierColor: Colors.white.withOpacity(0.7),
        backgroundColor: Colors.white,
        hightCard: 1.9);
  }

  Future<void> showWallets() async {
    showSlideDialog(
        context: context,
        child: ListWalletPopup(),
        barrierColor: Colors.white.withOpacity(0.7),
        backgroundColor: Colors.white,
        hightCard: 1.9);
  }

  createWallet() async {
    showSlideDialog(
        context: context,
        child:  CreateWalletPopup(),
        barrierColor: Colors.white.withOpacity(0.7),
        backgroundColor: Colors.white,
        hightCard: 2);
  }
}
