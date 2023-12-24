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
import 'package:flutter_udid/flutter_udid.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final navigatorState = GlobalKey<NavigatorState>();

class PlutocartApp extends StatefulWidget {
  const PlutocartApp({Key? key}) : super(key: key);

  @override
  _plutocartAppState createState() => _plutocartAppState();
}

class _plutocartAppState extends State<PlutocartApp> {
  int _selectedIndex = 0;
  List<Widget> pageRoutes = ListPage();
  @override
  void initState()  {
    super.initState();
    context.read<LoginBloc>().add(loginCustomer());
    context.read<LoginBloc>().add(loginGuest());
  }

    


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, stateLogin) {
          return BlocBuilder<WalletBloc, WalletState>(
            builder: (context, walletState) {
                  print("Start1 : ${!stateLogin.imei.isEmpty}");
                    print("Start1.2 : ${!stateLogin.email.isEmpty}");
                    print("Start1.2.3  ${stateLogin.email}");
                      print("Start1.2.4  ${stateLogin.imei}");
              return (!stateLogin.imei.isEmpty ||   !stateLogin.imei.isEmpty)
                  ? Skeletonizer(
                      enabled: walletState.status == WalletStatus.loading,
                      effect:
                          ShimmerEffect(duration: Duration(microseconds: 300)),
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
                    )
                  : FutureBuilder(
                      future: Future.delayed(Duration(seconds: 3)),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return HomeLogin();
                        } else {
                          return LoadStartApp();
                        }
                      },
                    );
            },
          );
        },
      ),
      title: "Plutocart",
      routes: AppRoute.all,
    );
  }
}
