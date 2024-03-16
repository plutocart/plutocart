import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plutocart/src/blocs/login_bloc/login_bloc.dart';
import 'package:plutocart/src/blocs/page_bloc/page_bloc.dart';
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
  List<Widget> pageRoutes = ListPage();

  @override
  void initState() {
    super.initState();
    context.read<LoginBloc>().add(LoginGuest());
    context.read<LoginBloc>().add(LoginMember());
    context.read<PageBloc>().add(saveIndexPage(context.read<PageBloc>().state.indexPage));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, stateLogin) {
          return BlocBuilder<WalletBloc, WalletState>(
            builder: (context, walletState) {
              print("stateLogin.imei : ${stateLogin.imei}");
              print("stateLogin.imei id account : ${stateLogin.accountId}");
              print(
                  "check case (stateLogin.imei.isNotEmpty || ( stateLogin.email.isNotEmpty && stateLogin.imei.isNotEmpty)) : ${(stateLogin.imei.isNotEmpty || (stateLogin.email.isNotEmpty && stateLogin.imei.isNotEmpty))}");
              print(
                  "check case (stateLogin.hasAccountGuest == false && stateLogin.singUpGuestSuccess == true) : ${(stateLogin.hasAccountGuest == false && stateLogin.signUpGuestSuccess == true)}");
              if ((stateLogin.imei.isNotEmpty ||
                      (stateLogin.email.isNotEmpty &&
                          stateLogin.imei.isNotEmpty)) ||
                  (stateLogin.hasAccountGuest == false &&
                      stateLogin.signUpGuestSuccess == true)) {
                return Skeletonizer(
                  enabled: walletState.status == WalletStatus.loading,
                  effect: ShimmerEffect(duration: Duration(seconds: 1)),
                  child: Stack(
                    children: [
                      BlocBuilder<PageBloc, PageState>(
                        builder: (context, state) {
                          return Scaffold(
                            resizeToAvoidBottomInset: false,
                            body: pageRoutes[state.indexPage],
                            floatingActionButton: ButtonTransaction(),
                            bottomNavigationBar: BottomNavigatorBar(
                              onTap: (index)  {
                                setState(() {
                                  context.read<PageBloc>().add(saveIndexPage(index));
                                });
                              },
                            ),
                          );
                        },
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
