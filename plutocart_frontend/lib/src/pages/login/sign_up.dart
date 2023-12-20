import 'package:flutter/material.dart';

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
        SizedBox(height: MediaQuery.sizeOf(context).height * 0.05,),
        Padding(
          padding: const EdgeInsets.only(left: 20 , right: 20),
          child: TextField(
            maxLength: 25,
            controller: _userNameAccountController,
            decoration: InputDecoration(
              labelText: "Username",
              labelStyle: TextStyle(
                color: Color(0xFF15616D), // Change the label text color to red
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 2,
                    color: Color(0xFF15616D)), // Change border color when active
                borderRadius: BorderRadius.circular(16),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1,
                    color: Color(0xFF15616D)), // Border color when inactive
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
          ),
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF15616D),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            onPressed: () {},
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
            )),
             SizedBox(height: MediaQuery.sizeOf(context).height * 0.2),
        Text(
          "Or do you already have an account?",
          style: TextStyle(
            decoration: TextDecoration.none,
            color: Color(0xFF15616D),
            fontSize: 16,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
          ),
        ),
         SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Continue With Goolge",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            )),
      ]),
    );
  }
}
