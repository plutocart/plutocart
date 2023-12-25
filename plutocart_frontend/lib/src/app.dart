import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plutocart/src/blocs/login_bloc/login_bloc.dart';
import 'package:plutocart/src/blocs/wallet_bloc/bloc/wallet_bloc.dart';
import 'package:plutocart/src/models/bottom_navigator_bar.dart';
import 'package:plutocart/src/models/button_transaction.dart';
import 'package:plutocart/src/models/helper.dart';
import 'package:plutocart/src/pages/loading/load_start_app.dart';
import 'package:plutocart/src/pages/login/home_login.dart';
import 'package:plutocart/src/router/router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PlutocartApp extends StatefulWidget {
  const PlutocartApp({Key? key}) : super(key: key);

  @override
  _PlutocartAppState createState() => _PlutocartAppState();
}

class _PlutocartAppState extends State<PlutocartApp> {
  bool _isLoginComplete = false;
  int _selectedIndex = 0;
  List<Widget> pageRoutes = ListPage();

  @override
  void initState() {
    super.initState();
    context.read<LoginBloc>().add(LoginCustomer());
    context.read<LoginBloc>().add(LoginGuest());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, stateLogin) {
          if (stateLogin.imei.isNotEmpty || stateLogin.email.isNotEmpty) {
            _isLoginComplete = true;
          } else {
            _isLoginComplete = false;
          }

          return BlocBuilder<WalletBloc, WalletState>(
            builder: (context, walletState) {
              if (_isLoginComplete) {
                return Skeletonizer(
                  enabled: walletState.status == WalletStatus.loading,
                  effect: ShimmerEffect(duration: Duration(microseconds: 300)),
                  child: Stack(
                    children: [
                      Scaffold(
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
                    ],
                  ),
                );
              } else {
                return FutureBuilder(
                  future: Future<void>.delayed(Duration(seconds: 3), () {}),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return HomeLogin();
                    } else {
                      return LoadStartApp();
                    }
                  },
                );
              }
            },
          );
        },
      ),
      title: "Plutocart",
      routes: AppRoute.all,
    );
  }
}
