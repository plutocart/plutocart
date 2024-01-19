import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plutocart/src/blocs/page_bloc/page_bloc.dart';

class BottomNavigatorBar extends StatefulWidget {
  final Function(int index) onTap;

  const BottomNavigatorBar({Key? key, required this.onTap}) : super(key: key);

  @override
  _BottomNavigatorBarState createState() => _BottomNavigatorBarState();
}

class _BottomNavigatorBarState extends State<BottomNavigatorBar> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = context.read<PageBloc>().state.indexPage;
  }

  @override
  Widget build(BuildContext context) {
    print("check state index page : ${context.read<PageBloc>().state.indexPage}");

    return BottomNavigationBar(
      currentIndex: selectedIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Color(0XFF15616D),
      unselectedItemColor: Color(0XFF707070),
      backgroundColor: Colors.white,
      onTap: (int index) {
        setState(() {
          selectedIndex = index;
        });
        widget.onTap(index);
      },
      items: [
        _buildBottomNavigationBarItem(
          icon: 'assets/icon/home_icon.png',
          label: 'Home',
          index: 0,
        ),
        _buildBottomNavigationBarItem(
          icon: 'assets/icon/transaction_icon.png',
          label: 'Tx',
          index: 1,
        ),
        _buildBottomNavigationBarItem(
          icon: 'assets/icon/goal_icon.png',
          label: 'Goals',
          index: 2,
        ),
        _buildBottomNavigationBarItem(
          icon: 'assets/icon/debt_icon.png',
          label: 'Debts',
          index: 3,
        ),
      ],
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem({
    required String icon,
    required String label,
    required int index,
  }) {
    return BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: ImageIcon(
          AssetImage(icon),
          size: selectedIndex == index ? MediaQuery.of(context).size.height * 0.035 : MediaQuery.of(context).size.height * 0.03,
          color: selectedIndex == index ? Color(0XFF15616D) : Color(0XFF707070),
        ),
      ),
      label: label,
    );
  }
}
