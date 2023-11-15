import 'package:flutter/material.dart';

class LaunchScreen extends StatefulWidget{
  LaunchScreen({super.key});

  State<LaunchScreen> createState(){
    return _LanuchScreenState();
  }

}

class _LanuchScreenState extends State<LaunchScreen>{
    
    @override
    Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(home: Scaffold(backgroundColor: Colors.white ),);
  }
}