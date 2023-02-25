import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../user_center/user_history.dart';

class LoginDemoPage extends StatefulWidget {
  LoginDemoPage();

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginDemoPage> {
  int _seconds = 0;
  bool _loadingImageUrl = true;
  String _imageUrl =
      'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEsAAAAaCAIAAABw/jbvAAABjElEQVR42s2Y7Q6DIAxF2dxm9v4P7JaYYNeP2wJFZ/ihFS2HlrZQtoGrlDL7W7VbFcq3VLLfl23sGoR0P7c6xCGvJIxwuq8sIx9TUKXv17029Y9Wh3FIwBmBx3buJHw8V9lUfUt57Q0M5basoLkehGdBJ5SQLp4FaRHS+27CiAf1E9K3AJISAkgmiRO6kArh9wMGWR8rofwRI6yKmwirsOJFFnkzIUVSCdWFKgl33YDQGhw1YHfaRLE0eM9+pxJKG7IYiAlTMplOSB2VIlmEch0GCdXpP5WQIamEFE+aRRIyNta/1T/9NGsRqjxMoqYK5n4uoZU50moJa/SuxMJjnE2E0j8TqkI1W1hhykr6QIFKKMMMSxKJVSHyUosQ1DQg0sjGtIAsP7SD6ahrZxDiGHM2YUoAwHuCRKWlo3LPIuze2qcR5mrqhnRL2WQvdXfW6T6cFkubIC804ywv5cc7/034M9rgaU9k1zPjOMs9p3APfkpcx+CKDx4r5TpqdNDHfHhbu+DUgmvQjLLbBy9uOkzsE/1jAAAAAElFTkSuQmCC';
  final phoneFormKey = GlobalKey<FormState>();
  final imageFormKey = GlobalKey<FormState>();
  final codeFormKey = GlobalKey<FormState>();

  final Map<String, String> formValue = new HashMap();

  late Timer _timer;

  Color LabelBlackColor = Color(0xFF1A1A1A);

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登录界面'),
      ),
      body: buildBody(),
    );
  }

  sendCode() async {
    _seconds = 60;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        timer.cancel(); // 取消重复计时
        return;
      }
      _seconds--;
      if (mounted) {
        setState(() {});
      }
    });
  }

  Widget buildBody() {
    return Container(
      padding: EdgeInsets.only(right: 20, top: 20),
      child: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              '快捷登录注册',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 26),
            ),
          ),
          SizedBox(height: 30),
          Neumorphic(
          margin: const EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 4),
          style: NeumorphicStyle(
          depth: NeumorphicTheme.embossDepth(context),
          boxShape: const NeumorphicBoxShape.stadium(),
          color: Colors.grey[200]),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
          child: Form(
            // key: phoneFormKey,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 28, minHeight: 28
//                      maxWidth: 150,
              ),
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                minLines: 1,
                maxLines: 4,
                decoration: InputDecoration(
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 4,vertical: 3),
                  // fillColor: Colors.green,
                  border: InputBorder.none,
                  // 提示框左边的控件
                  prefixIcon: Container(
                    width: 65,
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      '+86',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  hintText: "请输入手机号",
                  //解决登录界面中无法显示出居中文字效果方案
                  isCollapsed: true,
                ),

                onSaved: (mobile) {
                  /*if (mobile == null || mobile.isEmpty == true) {
                    return;
                  }*/
                  // formValue['mobile'] = mobile;
                },
              ),
            ),
          ),
    ),
         // ////////////////////////////////////////////////////
          const SizedBox(height: 20),
          Neumorphic(
            margin: const EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 4),
            style: NeumorphicStyle(
                depth: NeumorphicTheme.embossDepth(context),
                boxShape: const NeumorphicBoxShape.stadium(),
                color: Colors.grey[200]),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
            child: Form(
              // key: codeFormKey,
              child: ConstrainedBox(
                constraints:const BoxConstraints(maxHeight: 48, minHeight: 48
//                      maxWidth: 150,
                ),
                child: TextFormField(
                  // 这个地方和下面的数据使用情况相交的时候是有效的
                  textAlignVertical: TextAlignVertical.center,
                  style:const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  minLines: 1,
                  maxLines: 4,
                  decoration: InputDecoration(
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 4,vertical: 3),
                    border: InputBorder.none,
                    prefixIcon: Container(
                      width: 65,
                      alignment: Alignment.center,
                      child: const Text(
                        '验证码',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    hintText: '输入图形验证码',

                    suffixIcon: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        if (_loadingImageUrl) {
                          return;
                        } else {
                          _loadingImageUrl = true;
                          if (mounted) {
                            setState(() {});
                          }
                        }
                      },
                      child: SizedBox(

                        width: 100,
                        // height: 30,
                        child: Image.memory(
                          base64Decode(_imageUrl
                              .split(',')[1]
                              .replaceAll('\r', '')
                              .replaceAll('\n', '')),
                          width: 100,
                        ),
                      ),
                    ),
                    isCollapsed: true,

                  ),
                  onSaved: (text) {
                    if (text == null || text.isEmpty == true) {
                      return;
                    }
                    formValue['imageCode'] = text;
                  },
                ),
              ),
            ),
          ),


          const SizedBox(height: 20),
          Neumorphic(
            margin: const EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 4),
            style: NeumorphicStyle(
                depth: NeumorphicTheme.embossDepth(context),
                boxShape: const NeumorphicBoxShape.stadium(),
                color: Colors.grey[200]),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
            child: Form(
              // key: codeFormKey,
              child: ConstrainedBox(
                constraints:const BoxConstraints(maxHeight: 48, minHeight: 48
//                      maxWidth: 150,
                ),
                child: TextFormField(
                  // 这个地方和下面的数据使用情况相交的时候是有效的
                  textAlignVertical: TextAlignVertical.center,
                  style:const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  minLines: 1,
                  maxLines: 4,
                  decoration: InputDecoration(
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 4,vertical: 3),
                    border: InputBorder.none,
                    prefixIcon: Container(
                      width: 65,
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        '验证码',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    hintText: '请输入短信验证码',
                    suffixIcon: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        if (_seconds == 0) {
                          phoneFormKey.currentState?.save();
                          codeFormKey.currentState?.save();
                          sendCode();
                        }
                      },
                      child: Center(
                        widthFactor: 1,
                        child: Text(
                          _seconds == 0 ? '获取验证码' : '$_seconds秒',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    isCollapsed: true,

                  ),
                  onSaved: (text) {
                    if (text == null || text.isEmpty == true) {
                      return;
                    }
                    formValue['imageCode'] = text;
                  },
                ),
              ),
            ),
          ),

          const SizedBox(height: 50),
          Center(
            child:NeumorphicButton(
              style: NeumorphicStyle(
                boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(28),
                ),
                // color: Colors.grey[200],
                color: const Color.fromARGB(250, 250, 252, 254),
                shape: NeumorphicShape.flat,
              ),
              child: Container(
                color: const Color.fromARGB(250, 250, 252, 254),
                width: MediaQuery.of(context).size.width*0.8,
                height: 60,
                child: const Center(
                  child: Text('登录/注册',style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),),
                ),
              ),
              onPressed: () {},
            ) ,
          ),
        ],
      ),
    );
  }
}
