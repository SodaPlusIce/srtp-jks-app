import 'package:flutter/material.dart';
import 'package:jtjs/config/color.dart';
import 'package:jtjs/pages/AnimationPage.dart';
import 'package:via_logger/via_logger.dart';
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String _title = '智慧公交——定位';
  @override
  Widget build(BuildContext context) {
    Logger.minLevel= Level.WARNING;
    return  MaterialApp(
     /* title: _title,*/
      debugShowCheckedModeBanner: false,
      // 显示工程中的网格
      // debugShowMaterialGrid: true,
      theme: ThemeData(
        primarySwatch: createMaterialColor(const Color.fromARGB(250, 89, 151, 94)),
      ),
      home:  MyHome(),
    );
  }
}
