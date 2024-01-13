import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:plutocart/src/blocs/login_bloc/login_bloc.dart';
import 'package:plutocart/src/popups/custom_alert_popup.dart';
import 'package:plutocart/src/repository/login_repository.dart';
import 'package:plutocart/src/router/router.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  Future<String> fetchData() async {
    await Future.delayed(Duration(milliseconds: 500)); // Simulating delay
    return "New Data!";
  }

  bool guestSignInSuccess = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: Color(0xFF15616D),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: ShapeDecoration(
                  color: Color(0xFF15616D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.elliptical(186, 187),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: Row(
              children: [
                Image(
                  image:
                      AssetImage('assets/icon/plutocart_welcome_des_icon.png'),
                  width: MediaQuery.of(context).size.width * 0.8,
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BlocListener<LoginBloc, LoginState>(
                  listener: (context, stateLoginMember) {
                    if (stateLoginMember.signInGoogleStatus == true) {
                      print("case 1: check login google == true");
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRoute.app,
                        (route) => false,
                      );
                    } 
                  },
                  child: Column(
                    children: [
                      Text(
                        "Sign in by google account?",
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Color(0xFF15616D),
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, top: 20, right: 20, bottom: 30),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          onPressed: () async {
                            final storage = FlutterSecureStorage();
                            await storage.delete(key: "email");

                            print("start login customer google");
                           await LoginRepository.handleSignOut();
                           await storage.delete(key: "email"); 
                          await LoginRepository.handleSignIn();
                          context.read<LoginBloc>().add(loginEmailGoole());
                           await Future.delayed(Duration(milliseconds: 500));
                           print("check logic customer login : ${context.read<LoginBloc>().state.signInGoogleStatus}");
                          if (context.read<LoginBloc>().state.signInGoogleStatus == false) {
                              print("show diaoLog login google not found");
                            customAlertPopup(context, "Account google can't registered");
                          }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Image(
                                    image: AssetImage(
                                        'assets/icon/google_icon.png'),
                                    width: MediaQuery.of(context).size.width *
                                        0.08,
                                  ),
                                ),
                                Text(
                                  "Continues with Google",
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
