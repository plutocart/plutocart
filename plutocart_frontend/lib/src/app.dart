import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plutocart/src/blocs/home_page_bloc/bloc/home_page_bloc.dart';
import 'package:plutocart/src/models/bottom_navigator_bar.dart';
import 'package:plutocart/src/models/button_transaction.dart';
import 'package:plutocart/src/models/helper.dart';
import 'package:plutocart/src/router/router.dart';
import 'package:skeletonizer/skeletonizer.dart';

final navigatorState = GlobalKey<NavigatorState>();

class plutocartApp extends StatefulWidget {
  const plutocartApp({Key? key}) : super(key: key);

  @override
  _plutocartAppState createState() => _plutocartAppState();
}

class _plutocartAppState extends State<plutocartApp> {
  @override
  void initState() {
    context.read<HomePageBloc>().add(LoadingHomePage(1));
    super.initState();
  }

  int _selectedIndex = 0;
  List<Widget> pageRoutes = ListPage();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) {
          return Skeletonizer(
            enabled: state.isLoading,
            effect: ShimmerEffect(duration: Duration(microseconds: 300)),
            child: Stack(children: [
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
              //  Center(child:  CircularProgressIndicator(),)
            ]),
          );
        },
      ),
      title: "Plutocart",
      routes: AppRoute.all,
    );
  }
}
