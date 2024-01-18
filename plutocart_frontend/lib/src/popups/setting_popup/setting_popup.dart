import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plutocart/main.dart';
import 'package:plutocart/src/blocs/login_bloc/login_bloc.dart';
import 'package:plutocart/src/blocs/transaction_bloc/bloc/transaction_bloc.dart';
import 'package:plutocart/src/blocs/transaction_category_bloc/bloc/transaction_category_bloc.dart';
import 'package:plutocart/src/blocs/wallet_bloc/bloc/wallet_bloc.dart';
import 'package:plutocart/src/interfaces/slide_pop_up/slide_popup_dialog.dart';
import 'package:plutocart/src/popups/action_popup.dart';
import 'package:plutocart/src/popups/custom_alert_popup.dart';
import 'package:plutocart/src/popups/loading_page_popup.dart';
import 'package:plutocart/src/repository/login_repository.dart';

class SettingPopup extends StatefulWidget {
  final String accountRole;
  final String? email;
  const SettingPopup({Key? key, required this.accountRole, this.email})
      : super(key: key);
  @override
  _SettingPopupState createState() => _SettingPopupState();
}

class _SettingPopupState extends State<SettingPopup> {
  TextStyle globalTextStyleRedHeadline = TextStyle(
    color: Colors.red,
    fontSize: 16,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
    height: 0,
  );
  TextStyle globalTextStyleRedDes = TextStyle(
      color: Colors.red,
      fontSize: 14,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,
      height: 0,
      decoration: TextDecoration.underline);
  TextStyle globalTextStyleGreenHeadline = TextStyle(
    color: Color(0xFF15616D),
    fontSize: 18,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
    height: 0,
  );
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
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 16),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Image(
                  image: AssetImage('assets/icon/icon_launch.png'),
                  width: MediaQuery.of(context).size.width * 0.1,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.accountRole,
                    style: TextStyle(
                      color: Color(0xFF15616D),
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                  widget.accountRole == "Member"
                      ? Text("${widget.email}")
                      : SizedBox.shrink(),
                ],
              )
            ],
          ),
        ),
        widget.accountRole == "Member"
            ? SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: BlocConsumer<LoginBloc, LoginState>(
                  buildWhen: (previous, current) =>
                      current.isUpdateAccount != previous.isUpdateAccount,
                  listener: (context, state) async {
                    print("check state in setting popup.dart : $state");
                    context.read<LoginBloc>().add(LoginMember());
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(
                            width: 1,
                            color: Colors.transparent,
                          ),
                        ),
                        elevation: 3,
                      ),
                      onPressed: () async {
                        await LoginRepository.handleSignIn();
                        context.read<LoginBloc>().add(UpdateAccountToMember());
                        showLoadingPagePopUp(context);
                        await Future.delayed(Duration(milliseconds: 1500));
                        Navigator.pop(context);
                        Navigator.pop(context);
                        if (context.read<LoginBloc>().state.isUpdateAccount ==
                            false) {
                          customAlertPopup(
                              context,
                              "Update to account member unsuccessful",
                              Icons.error_outline_rounded,
                              Colors.red.shade200);
                        }

                        print("object state : ${state.email}");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 10,
                              left: 10,
                              top: 10,
                              bottom: 10,
                            ),
                            child: Image(
                              image: AssetImage('assets/icon/google_icon.png'),
                              width: MediaQuery.of(context).size.width * 0.08,
                            ),
                          ),
                          Text(
                            "Sign In with Google",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
        SizedBox(
          height: widget.accountRole == "Member" ? 5 : 20,
        ),
        widget.accountRole == "Member"
            ? SizedBox.shrink()
            : Text(
                "Enter your email and become our member",
                style: TextStyle(
                  color: Color(0xFF1A9CB0),
                  fontSize: 12,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w500,
                  height: 0.12,
                ),
              ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.07,
          decoration: ShapeDecoration(
            color: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(width: 1, color: Colors.red),
            ),
          ),
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () async {
                  ActionDeleteAccount();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                child: Center(
                  child: Text("Delete Account Guest"),
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        widget.accountRole == "Member"
            ? Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.07,
                decoration: ShapeDecoration(
                  color: Color(0xFF15616D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(width: 1, color: Color(0xFF15616D)),
                  ),
                ),
                child: BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () async {
                        context.read<LoginBloc>().add(LogOutAccountMember());
                        resetAllBlocs();
                        Navigator.pop(context);
                        runApp(MyWidget());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                      child: Center(child: Text("Sign Out")),
                    );
                  },
                ),
              )
            : SizedBox.shrink()
      ],
    );
  }

//  สำคัญต้องลบทุก Bloc
  void resetAllBlocs() {
    context.read<WalletBloc>().add(ResetWallet());
    context.read<TransactionCategoryBloc>().add(ResetTransactionCategory());
    context.read<TransactionBloc>().add(ResetTransaction());
    context.read<LoginBloc>().add(ResetLogin());
  }

  ActionDeleteAccount() async {
    showSlideDialog(
        context: context,
        child: Container(
          // color: Colors.green,
          constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width * 1,
              minHeight: MediaQuery.of(context).size.height * 0.3),
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Text(
                      "Delete Account",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 24,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Image(
                      image: AssetImage('assets/icon/icon_launch.png'),
                      width: MediaQuery.of(context).size.width * 0.07,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "WARNING !",
                      style: globalTextStyleRedHeadline,
                    ),
                    Text(
                      "Account deletion is irreversible. Proceed with caution",
                      style: globalTextStyleRedDes,
                    )
                  ],
                ),
                ActionPopup(
                  bottonFirstName: "Cancel",
                  bottonSecondeName: "Delete",
                  bottonFirstNameFunction: () => Navigator.pop(context),
                  bottonSecondeNameFunction: () {
                    context.read<LoginBloc>().add(DeleteAccount());
                    resetAllBlocs();
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        ),
        barrierColor: Colors.white.withOpacity(0.7),
        backgroundColor: Colors.white,
        hightCard: 1.5);
  }
}
