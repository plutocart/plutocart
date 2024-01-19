import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plutocart/src/blocs/login_bloc/login_bloc.dart';
import 'package:plutocart/src/popups/setting_popup.dart';

class GoalPage extends StatefulWidget {
  const GoalPage({Key? key}) : super(key: key);

  @override
  _GoalPageState createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Goals",
              style: TextStyle(color: Color(0xFF15616D)),
            ),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return IconButton(
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
                );
              },
            )
          ],
        ),
        backgroundColor: Colors.white10,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          children: [
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(width: 1),
                  ),
                  gradient: RadialGradient(
                    center: Alignment(0.84, 0.67),
                    radius: 0.85,
                    colors: [Color(0x7AD9ED92), Color(0xB215616D)],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Image(
                            image: AssetImage('assets/icon/icon_launch.png'),
                            width: MediaQuery.of(context).size.width * 0.15,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only( bottom: 30),
                          child: Image(
                            image: AssetImage('assets/icon/plus_icon.png'),
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white , 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)
                        )
                      ),
                        onPressed: () {},
                        child: Text(
                          'Click add your new Goal !',
                          style: TextStyle(
                            color: Color(0xFF15616D),
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
