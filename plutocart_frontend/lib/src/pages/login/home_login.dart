import 'package:flutter/material.dart';

class HomeLogin extends StatefulWidget {
  const HomeLogin({Key? key}) : super(key: key);

  @override
  _HomeLoginState createState() => _HomeLoginState();
}

class _HomeLoginState extends State<HomeLogin> {
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
                SizedBox(
                  height: 9,
                ),
                AnimatedOpacity(
                  opacity: opacityButtons,
                  duration: Duration(milliseconds: 300),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
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
                        onPressed: () {},
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
                  opacity: opacityText,
                  duration: Duration(milliseconds: 500),
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      alignment: Alignment(1, 2),
                    ),
                    child: Text(
                      'Try using it without registration.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
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
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.height * 0.2914,
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
}
