import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:plutocart/src/blocs/login_bloc/login_bloc.dart';
import 'package:plutocart/src/repository/login_repository.dart';
import 'package:plutocart/src/router/router.dart';

class LoginInUp extends StatefulWidget {
  final String? pathImageDes;
  final double? sizeImageDes;
  final String? messageButtonGuest;
  final String? messageButtonGoogle;
  final LoginGuest? signInGuest;
  final loginEmailGoole? signInCustomer;
  final CreateAccountGuest? signUpGuest;
  final CreateAccountCustomer? signUpCustomer;
  final String? signInOrUp;

  const LoginInUp(
      {Key? key,
      this.pathImageDes,
      this.sizeImageDes,
      this.messageButtonGuest,
      this.messageButtonGoogle, this.signInGuest, this.signInCustomer, this.signUpGuest, this.signUpCustomer, this.signInOrUp})
      : super(key: key);

  @override
  _LoginInUpState createState() => _LoginInUpState();
}

class _LoginInUpState extends State<LoginInUp> {
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
                image: AssetImage(widget.pathImageDes!),
                width: MediaQuery.sizeOf(context).width * widget.sizeImageDes!,
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
                widget.signInOrUp == "in" ?
                context.read<LoginBloc>().add(widget.signInGuest!) :
                context.read<LoginBloc>().add(widget.signUpGuest!);
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
                  widget.messageButtonGuest!,
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
                final storage = new FlutterSecureStorage();
                String? imei = await storage.read(key: "imei");
                print("email23 : ${imei}");
                  widget.signInOrUp == "in" ?
                context.read<LoginBloc>().add(widget.signInCustomer!) :
                context.read<LoginBloc>().add(widget.signUpCustomer!);
                FocusScope.of(context).unfocus();
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
                      widget.messageButtonGoogle!,
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

  void customSignUpPopup(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: Container(
            margin: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Close'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
