import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plutocart/src/blocs/login_bloc/login_bloc.dart';
import 'package:plutocart/src/repository/login_repository.dart';
import 'package:plutocart/src/router/router.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
        BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF15616D),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(color: Color(0xFF15616D)),
                ),
              ),
              onPressed: () async {
                context.read<LoginBloc>().add(createAccountGuest());
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
                if (Navigator.of(context, rootNavigator: true).canPop()) {
                  Navigator.of(context, rootNavigator: true)
                      .pop(); // Dismiss the AlertDialog
                }

                // Navigate to the home screen
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoute.app,
                  (route) => false,
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Continue As Guest",
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
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              onPressed: () async {
                context.read<LoginBloc>().add(createAccountCustomer());
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
                if (Navigator.of(context, rootNavigator: true).canPop()) {
                  Navigator.of(context, rootNavigator: true)
                      .pop(); // Dismiss the AlertDialog
                }

                // Navigate to the home screen
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoute.app,
                  (route) => false,
                );
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
