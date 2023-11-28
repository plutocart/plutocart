import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:plutocart/src/app.dart';
import 'package:plutocart/src/blocs/wallet_bloc/bloc/wallet_bloc.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(MyWidget());
  });
  FlutterNativeSplash.remove();
}

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    final walletBloc = BlocProvider(create: (context) => WalletBloc());
    return MultiBlocProvider(
        providers: [walletBloc],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                textTheme: TextTheme(
              displayLarge: TextStyle(
                  fontFamily: 'Roboto', fontSize: 16, color: Color(0xFF15616D)),
            )),
            home: Scaffold(
              resizeToAvoidBottomInset: false,
              body: plutocartApp(),
            )));
  }
}
