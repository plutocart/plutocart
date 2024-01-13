import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:plutocart/src/blocs/login_bloc/login_bloc.dart';
import 'package:plutocart/src/popups/custom_alert_popup.dart';
import 'package:plutocart/src/popups/loading_page_popup.dart';
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
                  image: AssetImage('assets/icon/plutocart_des_icon.png'),
                  width: MediaQuery.of(context).size.width * 0.5,
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BlocListener<LoginBloc, LoginState>(listener: (context, state) {
                  if ((state.hasAccountGuest == false &&
                      state.signUpGuestSuccess == true)) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoute.app,
                      (route) => false,
                    );
                  } else if ((state.hasAccountMember == false &&
                          state.signUpMemberSuccess == true) ||
                      (state.hasAccountMember == true &&
                          state.signUpMemberSuccess == false)) {
                  } else {
                    customAlertPopup(
                        context, "Possesses a registered account");
                  }
                }, child: BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return state.hasAccountGuest == false
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF15616D),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                side: BorderSide(color: Color(0xFF15616D)),
                              ),
                            ),
                            onPressed: () async {
                              print("start sign up account guest");
                              context
                                  .read<LoginBloc>()
                                  .add(CreateAccountGuest());
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                "Sign Up As Guest",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          )
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                side: BorderSide(color: Colors.grey),
                              ),
                            ),
                            onPressed:
                                null, // ถ้าเงื่อนไขเป็นเท็จ ปุ่มจะถูกปิดการใช้งาน
                            child: Text(
                              "Sign Up As Guests",
                              style: TextStyle(
                                color: Colors
                                    .grey, // เปลี่ยนสีตามที่ต้องการเมื่อปุ่มถูกปิดการใช้งาน
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          );
                  },
                )),
                Column(
                  children: [
                    Column(
                      children: [
                        Text(
                          "Or sign up by google account? ",
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Color(0xFF15616D),
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                      "Has an account? Google will automatically log in.",
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Color(0xFF15616D),
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                      ],
                    ),
                    BlocListener<LoginBloc, LoginState>(
                      listener: (context, state) async {
                        final storate = FlutterSecureStorage();
                        String? email = await storate.read(key: "email");
                        print(
                            "check email from storage logic create account customer : ${email}");
                        print(
                            "check account id in signup class logic create account customer: ${state.accountId}");
                        print(
                            "check account role signup class logic create account customer: ${state.accountRole}");
                        print(
                            "check email signup class logic create account customer: ${state.email}");
                        print(
                            "check logic has account customer : ${state.hasAccountMember}");
                        print(
                            "check logic has account customer success : ${state.signUpMemberSuccess}");
                        if ((state.hasAccountMember == false &&
                            state.signUpMemberSuccess == true)) {
                          print("check logic has account customer conmplete");
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRoute.app,
                            (route) => false,
                          );
                        } else if ((state.hasAccountGuest == true &&
                                state.signUpGuestSuccess == false) ||
                            (state.hasAccountGuest == false &&
                                state.signUpGuestSuccess == true)) {
                        } else if (state.email == null && state.email == "") {
                        } else if (state.email != null && state.email != "") {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRoute.app,
                            (route) => false,
                          );
                        }
                      },
                      child: Padding(
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
                            context
                                .read<LoginBloc>()
                                .add(CreateAccountMember());
                                
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
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
