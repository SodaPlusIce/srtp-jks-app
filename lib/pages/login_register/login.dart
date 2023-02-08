import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';

class LoginDemoPage extends StatefulWidget {
  LoginDemoPage({required Key key});

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
        title: Text('登录示例demo'),
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
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              '快捷登录注册',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 26),
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Form(
              key: phoneFormKey,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 58, minHeight: 58
//                      maxWidth: 150,
                ),
                child: TextFormField(
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    contentPadding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                    fillColor: Colors.white,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: LabelBlackColor, width: 1),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFF5F5F5),
                        width: 1.0,
                      ),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFF5F5F5),
                        width: 1.0,
                      ),
                    ),
                    prefixIcon: Container(
                      width: 65,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '+86',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    hintText: '请输入手机账号',
                    hintStyle:
                    TextStyle(fontSize: 16, color: Color(0xFF999999)),
                  ),
                  onSaved: (mobile) {
                    if (mobile == null || mobile.isEmpty == true) {
                      return;
                    }
                    formValue['mobile'] = mobile;
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Form(
              key: codeFormKey,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 58, minHeight: 58
//                      maxWidth: 150,
                ),
                child: TextFormField(
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    contentPadding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                    fillColor: Colors.white,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: LabelBlackColor, width: 1),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFF5F5F5),
                        width: 1.0,
                      ),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFF5F5F5),
                        width: 1.0,
                      ),
                    ),
                    prefixIcon: Container(
                      width: 65,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '验证码',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    hintText: '请输入图形验证码',
                    hintStyle:
                    TextStyle(fontSize: 16, color: Color(0xFF999999)),
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
                      child: Container(
                        width: 100,
                        height: 30,
                        child: Image.memory(
                          base64Decode(_imageUrl
                              .split(',')[1]
                              .replaceAll('\r', '')
                              .replaceAll('\n', '')),
                          width: 100,
                        ),
                      ),
                    ),
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
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Form(
              key: imageFormKey,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 58, minHeight: 58
//                      maxWidth: 150,
                ),
                child: TextFormField(
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    contentPadding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                    fillColor: Colors.white,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: LabelBlackColor, width: 1),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFF5F5F5),
                        width: 1.0,
                      ),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFF5F5F5),
                        width: 1.0,
                      ),
                    ),
                    prefixIcon: Container(
                      width: 65,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '验证码',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    hintText: '请输入短信验证码',
                    hintStyle:
                    TextStyle(fontSize: 16, color: Color(0xFF999999)),
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
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  onSaved: (text) {
                    if (text == null || text.isEmpty == true) {
                      return;
                    }
                    formValue['code'] = text;
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: GestureDetector(
              onTap: () {
                phoneFormKey.currentState?.save();
                imageFormKey.currentState?.save();
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                height: 48,
                color: LabelBlackColor,
                alignment: Alignment.center,
                child: Text(
                  '登录/注册',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
