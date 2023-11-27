import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

class BottomNavigatorBar extends StatelessWidget {
  final Function(int index) onTap;
  const BottomNavigatorBar({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StyleProvider(
      style: Style(),
      child: ConvexAppBar(
        initialActiveIndex: 0,
        height: 50,
        top: -10,
        curveSize: 300,
        style: TabStyle.react,
        activeColor: Color(0XFF15616D),
        items: [
          TabItem(
              icon: ImageIcon(AssetImage('assets/icon/home_icon.png'),
                  color: Color(0XFF15616D)),
              title: 'Home', fontFamily: 'Roboto'),
          TabItem(
              icon: ImageIcon(AssetImage('assets/icon/transaction_icon.png'),
                  color: Color(0XFF15616D)),
              title: 'Tx' , fontFamily: 'Roboto'),
          // TabItem(icon: ImageIcon(AssetImage('assets/icon/graph_icon.png') , color: Color(0XFF15616D)) ,title: 'Graphs'),
          // TabItem(icon: ImageIcon(AssetImage('assets/icon/goal_icon.png') , color: Color(0XFF15616D)), title: 'Goals'),
          // TabItem(icon: ImageIcon(AssetImage('assets/icon/debt_icon.png') , color: Color(0XFF15616D)), title: 'Debts'),
        ],
        onTap: (int index) {
          onTap(index);
        },
        backgroundColor: Color(0XFFFFFF),
        color: Color(0XFF15616D),
      ),
    );
  }
}

class Style extends StyleHook {
  @override
  double get activeIconSize => 30;

  @override
  double get activeIconMargin => 10;

  @override
  double get iconSize => 24;
  @override
  TextStyle textStyle(Color color, String? fontFamily) {
    return TextStyle(fontSize: 12, color: Color(0XFF707070));
  }
}
