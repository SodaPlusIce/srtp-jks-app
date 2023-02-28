import 'package:flutter/material.dart';
import 'package:jtjs/config/color.dart';
import 'package:jtjs/driver_pages/my_home_page.dart';
import 'package:jtjs/pages/login.dart';
import 'package:jtjs/pages/my_home_page.dart';
import 'package:jtjs/pages/temp.dart';
import './pages/location.dart';
import './pages/map.dart';
import './pages/user_center.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String _title = '智慧公交——定位';
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
     /* title: _title,*/
      debugShowCheckedModeBanner: false,
      // 显示工程中的网格
      // debugShowMaterialGrid: true,
      theme: ThemeData(
        primarySwatch: createMaterialColor(const Color.fromARGB(250, 89, 151, 94)),
      ),
      home: const MyHomePage(),
    );
  }
}
