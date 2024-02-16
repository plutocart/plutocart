import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plutocart/src/blocs/login_bloc/login_bloc.dart';
import 'package:plutocart/src/interfaces/slide_pop_up/slide_popup_dialog.dart';
import 'package:plutocart/src/popups/debt_popup/add_debt_popup.dart';
import 'package:plutocart/src/popups/setting_popup.dart';

class DebtPage extends StatefulWidget {
  const DebtPage({Key? key}) : super(key: key);

  @override
  _DebtPageState createState() => _DebtPageState();
}

class _DebtPageState extends State<DebtPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Debt",
                    style: TextStyle(
                      color: Color(0xFF15616D),
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Roboto",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Image.asset(
                      "assets/icon/icon_launch.png",
                      width: 25,
                      height: 25,
                    ),
                  ),
                ],
              ),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return Row(
                  children: [
                     IconButton(
                        alignment: Alignment.centerRight,
                        splashRadius: 5,
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<CircleBorder>(
                            CircleBorder(),
                          ),
                        ),
                        onPressed: ()  {
                          createDebt();
                        },
                        icon: Image.asset(
                          'assets/icon/plus_icon.png',
                          width: 20,
                        )),  
                    IconButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<CircleBorder>(
                          CircleBorder(),
                        ),
                      ),
                      splashRadius: 20,
                      onPressed: () {
                        SettingPopUp(state.accountRole, state.email, context);
                      },
                      icon: Icon(Icons.settings),
                      color: Color(0xFF15616D),
                    ),
                  ],
                );
              },
            )
          ],
        ),
        backgroundColor: Colors.white10,
        elevation: 0,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Column(
              children: [
              
              ],
            ),
          ),
        ),
      ),
    );
  }

  createDebt() async {
    showSlideDialog(
        context: context,
        child: AddDebtPopup(),
        barrierColor: Colors.white.withOpacity(0.7),
        backgroundColor: Colors.white,
        hightCard: 3);
  }
}
