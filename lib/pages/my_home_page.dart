import 'package:flutter/material.dart';
import 'package:jtjs/pages/user_center.dart';
import 'package:jtjs/pages/temp.dart';
import 'package:jtjs/pages/user_center/user_collection.dart';
import 'package:jtjs/pages/user_center/user_history.dart';
import 'package:jtjs/pages/user_center/user_information.dart';
import 'package:jtjs/pages/user_center/user_wallet.dart';

import '../config/custom_animated_bottom_bar.dart';
import 'location.dart';
import 'map.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  // 没有在交互的状态颜色
  final _inactiveColor = Colors.black;
  // 显示的标题
  List<String> titlesOne = ['导航','收藏','历史','钱包','我的'];
  // 点击显示的颜色
  Color colorClicked = const Color.fromARGB(255,87 , 150, 92);
  late List<List<MyBottomNavigationBarItem>>userOrDriver;
  Color backgroundColor = const Color.fromARGB(250, 242, 243, 247);
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static  final List<Widget> _widgetOptions = <Widget>[
    // const LocationPage(),
    const MapPage(),
    const UserCollPage(),
    const UserHisPage(),
    const UserWallPage(),
    const CenterPage(),
    // const TempPageForTest(),
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
      backgroundColor: Colors.white,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeInOut,
      onItemSelected: (index) => setState(() => _selectedIndex = index),
      items:<MyBottomNavigationBarItem> [
        MyBottomNavigationBarItem(
          icon:const Icon(Icons.navigation_outlined),
          title: Text(titlesOne[0]),
          activeColor:colorClicked,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        MyBottomNavigationBarItem(
          icon: const Icon(Icons.star_border_outlined),
          title: Text(titlesOne[1]),
          activeColor: colorClicked,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        MyBottomNavigationBarItem(
          icon: const Icon(Icons.history),
          title: Text(
            titlesOne[2],
          ),
          activeColor: colorClicked,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        MyBottomNavigationBarItem(
          icon: const Icon(Icons.wallet),
          title: Text(
            titlesOne[3],
          ),
          activeColor: colorClicked,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        MyBottomNavigationBarItem(
          icon: const Icon(Icons.person_outlined),
          title: Text(
            titlesOne[4],
          ),
          activeColor: colorClicked,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

}
