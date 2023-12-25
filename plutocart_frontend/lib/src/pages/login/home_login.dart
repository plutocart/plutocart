import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:plutocart/src/blocs/login_bloc/login_bloc.dart';
import 'package:plutocart/src/pages/login/login_in_up.dart';
import 'package:plutocart/src/router/router.dart';

class HomeLogin extends StatefulWidget {
  const HomeLogin({Key? key}) : super(key: key);

  @override
  _HomeLoginState createState() => _HomeLoginState();
}

class _HomeLoginState extends State<HomeLogin> {
  final storage = new FlutterSecureStorage();
  String _udid = 'Unknown';
  double opacityContainer = 0.0;
  double opacityImage = 0.0;
  double opacityButtons = 0.0;
  double opacityText = 0.0;
  double opacityLastContainer = 0.0;

  @override
  void initState() {
    super.initState();
    _startOpacityAnimation();
  }

  void _startOpacityAnimation() {
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        opacityImage = 1.0;
      });
    });

    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        opacityContainer = 1.0;
      });
    });

    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        opacityButtons = 1.0;
      });
    });

    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        opacityText = 1.0;
      });
    });

    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        opacityLastContainer = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedOpacity(
          opacity: opacityContainer,
          duration: Duration(milliseconds: 300),
          child: Container(
            height: MediaQuery.of(context).size.height * 1,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
                AnimatedOpacity(
                  opacity: opacityImage,
                  duration: Duration(milliseconds: 300),
                  child: Image(
                    image: AssetImage('assets/icon/logo_login_icon.png'),
                    width: MediaQuery.of(context).size.width * 0.6,
                  ),
                ),
                AnimatedOpacity(
                  opacity: opacityButtons,
                  duration: Duration(milliseconds: 300),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(_createRoute(LoginInUp(
                            signInOrUp: "in",
                            pathImageDes:
                                'assets/icon/plutocart_welcome_des_icon.png',
                            sizeImageDes: 0.8,
                            messageButtonGuest: 'Continue As Guest',
                            messageButtonGoogle: " Sign In With Google",
                            signInGuest: LoginGuest(),
                            signInCustomer: loginEmailGoole(),
                          )));
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          backgroundColor: Color(0xFF15616D),
                          padding: EdgeInsets.only(
                            bottom: 10,
                            left: 30,
                            right: 30,
                            top: 10,
                          ),
                        ),
                        child: Text(
                          'Sign In',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(_createRoute(LoginInUp(
                            signInOrUp: "up",
                            pathImageDes: 'assets/icon/plutocart_des_icon.png',
                            sizeImageDes: 0.5,
                            messageButtonGuest: 'Sign Up As Guest',
                            messageButtonGoogle: " Sign Up With Google",
                            signUpGuest: CreateAccountGuest(),
                            signUpCustomer: CreateAccountCustomer(),
                          )));
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          backgroundColor: Color(0xFF15616D),
                          padding: EdgeInsets.only(
                            bottom: 10,
                            left: 30,
                            right: 30,
                            top: 10,
                          ),
                        ),
                        child: Text(
                          'Sign Up',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedOpacity(
                  opacity: opacityLastContainer,
                  duration: Duration(milliseconds: 500),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: ShapeDecoration(
                          color: Color(0xFF15616D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.elliptical(600, 600),
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
        ),
      ],
    );
  }

  Route _createRoute(Widget pageWidget) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => pageWidget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0,
            0.0); // Change the X value to 1.0 for sliding from left to right
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
