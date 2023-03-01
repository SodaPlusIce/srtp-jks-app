import 'package:flutter/material.dart';
import 'package:jtjs/config/appbar_settings.dart';
import 'package:jtjs/pages/waiting_car.dart';
import 'package:jtjs/pages/user_center.dart';
import 'package:jtjs/pages/login.dart';
class TempPageForTest extends StatefulWidget {
  const TempPageForTest({Key? key}) : super(key: key);

  @override
  State<TempPageForTest> createState() => _TempPageForTestState();
}

class _TempPageForTestState extends State<TempPageForTest> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color.fromARGB(255, 244, 244, 244),
      appBar: UnionAppBar(title: "测试页面",),
      body: ListView(
        children: [
              TextButton(onPressed: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context)=>const CenterPage()));
              }, child: const Text("个人中心")),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()));
              }, child: const Text("登录页面")),
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const WaitingCarPage()));
          }, child: const Text("等车界面")),
          TextButton(onPressed: (){}, child:const Text("确定下单"))
        ],
      ),
    );
  }
}
