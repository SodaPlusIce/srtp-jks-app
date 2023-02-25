import 'package:flutter/material.dart';
import 'package:jtjs/pages/car_success/waiting_car.dart';
import 'package:jtjs/pages/center.dart';
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
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 166, 211, 242),
        // backgroundColor: Colors.lightBlueAccent,
        // shadowColor: Colors.white,
        // elevation: 0,
        // leading: Icon(Icons.arrow_back_outlined),
        title: const Text('测试页面',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: Colors.black,
            // fontFamily: "宋体"
          ),
        ),
      ),
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
            Navigator.push(context, MaterialPageRoute(builder: (context)=> WaitingCarPage()));
          }, child: const Text("等车界面")),
        ],
      ),
    );
  }
}
