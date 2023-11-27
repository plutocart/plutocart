import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plutocart/src/blocs/wallet_bloc/bloc/wallet_bloc.dart';
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
  final walletBloc = BlocProvider(create: (context) => WalletBloc());
  int _selectedIndex = 0;
  List<Widget> pageRoutes = ListPage();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [walletBloc],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
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
      ),
    );
  }
}
