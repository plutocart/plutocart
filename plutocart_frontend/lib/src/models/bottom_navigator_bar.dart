import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plutocart/src/blocs/page_bloc/page_bloc.dart';

class BottomNavigatorBar extends StatelessWidget {
  final Function(int index) onTap;

  const BottomNavigatorBar({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("check state index page : ${context.read<PageBloc>().state.indexPage}");

    return BottomNavigationBar(
      currentIndex: context.read<PageBloc>().state.indexPage,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Color(0XFF15616D),
      unselectedItemColor: Color(0XFF898989),
      backgroundColor: Colors.white,
      onTap: (int index) {
        onTap(index);
      },
      items: [
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage('assets/icon/home_icon.png'),
            color: Color(0XFF15616D),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage('assets/icon/transaction_icon.png'),
            color: Color(0XFF15616D),
          ),
          label: 'Trans',
        ),
           BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage('assets/icon/graph_icon.png'),
            color: Color(0XFF15616D),
          ),
          label: 'Graph',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage('assets/icon/goal_icon.png'),
            color: Color(0XFF15616D),
          ),
          label: 'Goals',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage('assets/icon/debt_icon.png'),
            color: Color(0XFF15616D),
          ),
          label: 'Debts',
        ),
      ],
    );
  }
}
