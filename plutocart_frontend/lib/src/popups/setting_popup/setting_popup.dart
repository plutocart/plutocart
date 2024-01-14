import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plutocart/main.dart';
import 'package:plutocart/src/blocs/login_bloc/login_bloc.dart';
import 'package:plutocart/src/blocs/reset_bloc.dart';
import 'package:plutocart/src/blocs/transaction_bloc/bloc/transaction_bloc.dart';
import 'package:plutocart/src/blocs/transaction_category_bloc/bloc/transaction_category_bloc.dart';
import 'package:plutocart/src/blocs/wallet_bloc/bloc/wallet_bloc.dart';
import 'package:plutocart/src/popups/loading_page_popup.dart';

class SettingPopup extends StatefulWidget {
  final String accountRole;
  final String? email;
  const SettingPopup({Key? key, required this.accountRole, this.email})
      : super(key: key);
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
              Text(
                widget.accountRole,
                style: TextStyle(
                  color: Color(0xFF15616D),
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              )
            ],
          ),
        ),
        widget.accountRole == "Member"
            ? Padding(
                padding: const EdgeInsets.only(right: 40),
                child: Text(
                  "Email Member : ${widget.email}",
                  style: TextStyle(
                    color: Color(0xFF15616D),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side:
                              BorderSide(width: 1, color: Colors.transparent)),
                      elevation: 3),
                  onPressed: () async {
                    context.read<LoginBloc>().add(CreateAccountMember());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 10, left: 10, top: 10, bottom: 10),
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
                ),
              ),
        SizedBox(
          height: 20,
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
            color:
                widget.accountRole == "Member" ? Color(0xFF15616D) : Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                  width: 1,
                  color: widget.accountRole == "Member"
                      ? Color(0xFF15616D)
                      : Colors.red),
            ),
          ),
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () async {
                  if (widget.accountRole == "Member") {
                    context.read<LoginBloc>().add(LogOutAccountMember());
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MyWidget()),
                      (route) => false,
                    );
                    resetAllBlocs();
                  } else {
                    // Navigator.pushAndRemoveUntil(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => MyWidget()),
                    //   (route) => false,
                    // );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                child: Center(
                  child: widget.accountRole == "Member"
                      ? Text("Log out")
                      : Text("Delete Account Guest"),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  void resetAllBlocs() {
    context.read<WalletBloc>().add(ResetWallet());
    context.read<TransactionCategoryBloc>().add(ResetTransactionCategory());
    context.read<TransactionBloc>().add(ResetTransaction());
    context.read<LoginBloc>().add(ResetLogin());
  }
}
