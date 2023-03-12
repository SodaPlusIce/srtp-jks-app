import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:jtjs/pages/my_home_page.dart';

void main() {
  runApp(
      MaterialApp(
        home: MyHome(),
      )
  );
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> with SingleTickerProviderStateMixin{

  late AnimationController _controller;//AnimationController是Animation的一个子类，它可以控制Animation，可以控制动画的时间，类型，过渡3曲线
   late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    //上面两行代码表示初始化一个Animation控制器， vsync垂直同步，动画执行时间3000毫秒,然后我们设置一个Animation动画，使用上面设置的控制器


    //监听动画运行状态，当状态为completed时，动画执行结束，跳转首页
    _animation.addStatusListener((status){
      if(status == AnimationStatus.completed){
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context){
              return const MyHomePage();
            }),
                (route) => route == null
        );
      }
    });
    _controller.forward(); // 播放动画
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();//释放动画
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return FadeTransition(//透明度动画组件
      opacity: _animation, //动画
      child: Image.asset('assets/images/screen.png',fit: BoxFit.cover,)

    );
  }
}



