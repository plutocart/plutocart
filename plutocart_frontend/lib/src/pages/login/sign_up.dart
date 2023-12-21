import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plutocart/src/blocs/login_bloc/login_bloc.dart';
import 'package:plutocart/src/pages/login/google_login.dart';
import 'package:plutocart/src/router/router.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _userNameAccountController =
      new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white70,
      child: Column(children: [
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
                }),
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
                image: AssetImage('assets/icon/plutocart_des_icon.png'),
                width: MediaQuery.sizeOf(context).width * 0.5,
              )
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.05,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: TextField(
            maxLength: 25,
            controller: _userNameAccountController,
            decoration: InputDecoration(
              labelText: "Username",
              labelStyle: TextStyle(
                color: _userNameAccountController.text.length > 1
                    ? Color(0xFF15616D)
                    : Colors.red, // Change the label text color to red
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 2,
                    color: _userNameAccountController.text.length > 1
                        ? Color(0xFF15616D)
                        : Colors.red), // Change border color when active
                borderRadius: BorderRadius.circular(16),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1,
                    color: _userNameAccountController.text.length > 1
                        ? Color(0xFF15616D)
                        : Colors.red), // Border color when inactive
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Color(0xFF1A9CB0),
              fontSize: 16,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
            ),
            onChanged: (value) {
              setState(
                  () {}); // ใช้ setState เพื่อ rebuild widget tree เมื่อข้อมูลเปลี่ยนแปลง
            },
          ),
        ),
        BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _userNameAccountController.text.length > 0
                    ? Color(0xFF15616D)
                    : Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(
                    color: _userNameAccountController.text.length > 0
                        ? Color(0xFF15616D)
                        : Colors.transparent,
                  ),
                ),
              ),
              onPressed: _userNameAccountController.text.length > 0
                  ? () async {
                      if (_userNameAccountController.text.length > 0) {
                        context.read<LoginBloc>().add(createAccountGuest(
                            _userNameAccountController.text));
                        FocusScope.of(context).unfocus();

                        // Show the AlertDialog
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircularProgressIndicator(),
                                  SizedBox(height: 20),
                                  Text('Loading...'),
                                ],
                              ),
                            );
                          },
                        );

                        await Future.delayed(
                            Duration(seconds: 1)); // Wait for 3 seconds

                        // Check if the dialog is still open
                        if (Navigator.of(context, rootNavigator: true)
                            .canPop()) {
                          Navigator.of(context, rootNavigator: true)
                              .pop(); // Dismiss the AlertDialog
                        }

                        // Navigate to the home screen
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoute.app,
                          (route) => false,
                        );
                      }
                    }
                  : null,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  _userNameAccountController.text.length > 0
                      ? "Continue As Guest"
                      : "Please input username",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            );
          },
        ),
        SizedBox(height: MediaQuery.sizeOf(context).height * 0.2),
        Text(
          "Or sign up by google account?",
          style: TextStyle(
            decoration: TextDecoration.none,
            color: Color(0xFF15616D),
            fontSize: 16,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20 , right: 20 , top: 10),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              onPressed: () {
               GoogleSignInService.handleSignIn();
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Image(
                        image: AssetImage('assets/icon/google_icon.png'),
                        width: MediaQuery.sizeOf(context).width * 0.08,
                      ),
                    ),
                    Text(
                      "Sign up With Goolge",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ]),
    );
  }
}
