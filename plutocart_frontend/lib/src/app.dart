import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plutocart/src/blocs/home_page_bloc/bloc/home_page_bloc.dart';
import 'package:plutocart/src/blocs/login_bloc/login_bloc.dart';
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

class plutocartApp extends StatefulWidget {
  const plutocartApp({Key? key}) : super(key: key);

  @override
  _plutocartAppState createState() => _plutocartAppState();
}

class _plutocartAppState extends State<plutocartApp> {
  final storage = new FlutterSecureStorage();

  String _udid = 'Unknown';
  int _selectedIndex = 0;
  List<Widget> pageRoutes = ListPage();
  @override
  void initState()  {
    super.initState();
    initPlatformState();
    context.read<HomePageBloc>().add(LoadingHomePage());
    context.read<LoginBloc>().add(loginGuest());
  }

  Future<void> initPlatformState() async {
    String udid;
    try {
      udid = await FlutterUdid.consistentUdid;
      await storage.write(key: "imei", value: udid);
    } on Error {
      udid = 'Failed to get UDID.';
    }

    if (!mounted) return;

    setState(() {
      _udid = udid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, stateLogin) {
            storage.write(key: "accountId", value: stateLogin.accountId.toString());
          return BlocBuilder<HomePageBloc, HomePageState>(
            builder: (context, stateHomePage) {
              return (!stateLogin.imei.isEmpty)
                  ? Skeletonizer(
                      enabled: stateHomePage.isLoading,
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
