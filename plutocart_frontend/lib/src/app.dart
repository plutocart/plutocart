
import 'package:flutter/material.dart';
import 'package:plutocart/src/models/bottom_navigator_bar.dart';
import 'package:plutocart/src/models/button_transaction.dart';
import 'package:plutocart/src/models/helper.dart';
import 'package:plutocart/src/router/router.dart';


final navigatorState = GlobalKey<NavigatorState>();

class plutocartApp extends StatefulWidget {
  const plutocartApp({Key? key}) : super(key: key);

  @override
  _plutocartAppState createState() => _plutocartAppState();
}

class _plutocartAppState extends State<plutocartApp> {
   bool isConnected = true; 
  int _selectedIndex = 0;
  List<Widget> pageRoutes = ListPage();
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: pageRoutes[_selectedIndex],
          floatingActionButton: ButtonTransaction(),
          bottomNavigationBar: BottomNavigatorBar(
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
        title: "Plutocart",
        routes: AppRoute.all,
      )
    ;
  }

}
