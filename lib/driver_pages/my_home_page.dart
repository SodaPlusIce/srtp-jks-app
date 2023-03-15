
import 'dart:ui';

import 'package:jtjs/driver_pages/current_order.dart';
import 'package:jtjs/driver_pages/driver_center.dart';
import 'package:jtjs/driver_pages/driver_history.dart';

import '../config/custom_animated_bottom_bar.dart';
import 'package:flutter/material.dart';

class DriverHomePage extends StatefulWidget {
  const DriverHomePage({Key? key}) : super(key: key);

  @override
  State<DriverHomePage> createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  int _selectedIndex = 0;
  // 没有在交互的状态颜色
  final _inactiveColor = Colors.black;
  final _activeColor = const Color.fromARGB(250, 177, 195, 169);
  // 显示的标题
  List<String> titles = ['当前','历史', '我的'];
  late List<List<MyBottomNavigationBarItem>>userOrDriver;
  Color backgroundColor = const Color.fromARGB(250, 242, 243, 247);
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static  final List<Widget> _widgetOptions = <Widget>[
    const CurrentOrderPage(),
    const DriverHisPage(),
    const DriverCenterPage(),
    // LoginDemoPage(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar:_buildBottomBar() ,
    );
  }
  Widget _buildBottomBar() {
    return CustomAnimatedBottomBar(
      containerHeight: 56,
      // backgroundColor: backgroundColor,
      selectedIndex: _selectedIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeInOut,
      onItemSelected: (index) => setState(() => _selectedIndex = index),
      items:<MyBottomNavigationBarItem> [
        MyBottomNavigationBarItem(
          icon:const Icon(Icons.navigation_outlined),
          title: Text(titles[0]),
          activeColor: _activeColor,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        MyBottomNavigationBarItem(
          icon:const Icon(Icons.history),
          title: Text(
            titles[1],
          ),
          activeColor:_activeColor,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        MyBottomNavigationBarItem(
          icon:const Icon(Icons.person_outline),
          title: Text(
            titles[2],
          ),
          activeColor:_activeColor,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
