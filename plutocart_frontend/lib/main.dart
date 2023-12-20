import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:plutocart/src/app.dart';
import 'package:plutocart/src/blocs/home_page_bloc/bloc/home_page_bloc.dart';
import 'package:plutocart/src/blocs/login_bloc/login_bloc.dart';
import 'package:plutocart/src/blocs/wallet_bloc/bloc/wallet_bloc.dart';
import 'package:plutocart/src/pages/connection_internet/no_connection_internet.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    FlutterNativeSplash.remove();
    runApp(MyWidget());
  });
}

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  bool isConnected = true;
  @override
  Widget build(BuildContext context) {
    final walletBloc = BlocProvider(create: (context) => WalletBloc());
    final homePageBloc = BlocProvider(create: (context) => HomePageBloc());
    final loginBloc = BlocProvider(create: (context) => LoginBloc());
    return MultiBlocProvider(
        providers: [walletBloc, homePageBloc , loginBloc],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                textTheme: TextTheme(
              displayLarge: TextStyle(
                  fontFamily: 'Roboto', fontSize: 16, color: Color(0xFF15616D)),
            )),
            home: Scaffold(
              resizeToAvoidBottomInset: false,
              body: isConnected ? plutocartApp() : NoConnectionPage(),
            )));
  }

  Future<void> checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        isConnected = false; // ปรับสถานะการเชื่อมต่อ
      });
    } else if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      setState(() {
        isConnected = true; // ปรับสถานะการเชื่อมต่อ
      });
    }
  }

  late StreamSubscription<ConnectivityResult> subscription;

  void initConnectivity() {
    subscription = Connectivity().onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.none) {
        // No internet connection
      } else if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        // Connected to WiFi or mobile data
      }
    });
  }

  @override
  void initState() {
    super.initState();
    checkConnectivity();
    initConnectivity();
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }
}
