import 'dart:async';
import 'dart:io';

import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';
import 'package:flutter/material.dart';
import '../config/config.dart';
import 'package:permission_handler/permission_handler.dart';

import './location.dart';
import './user_center/user_information.dart';

class CenterPage extends StatefulWidget {
  const CenterPage({Key? key}) : super(key: key);

  @override
  State<CenterPage> createState() => _CenterPageState();
}

class _CenterPageState extends State<CenterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(250, 239, 249, 255),
      appBar: AppBar(
        // leading: Icon(Icons.arrow_back_outlined),
        title: const Text('智慧公交——主页'),
      ),
      body: Center(
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.all(10),
              color: Colors.greenAccent,
              elevation: 10,
              shadowColor: Colors.grey,
              child: Container(
                height: 100,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 85,
                        height: 85,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(42)),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/lake.jpg',
                            width: 85,
                            height: 85,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(10)),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const UserInfoPage()));
                        },
                        child: const Text(
                          "cdw",
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 26),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(30)),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.chat_outlined))
                    ]),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.all(10),
                  color: const Color.fromARGB(250, 250, 252, 254),
                  elevation: 10,
                  shadowColor: const Color.fromARGB(250, 231, 241, 251),
                  child: Container(
                      height: 60,
                      margin: const EdgeInsets.all(10),
                      child: TextButton.icon(
                        icon: const Icon(Icons.history),
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(120, 60)),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const LocationPage();
                          }));
                        },
                        label: const Text(
                          '历史记录',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      )),
                ),
                const Padding(padding: EdgeInsets.all(10)),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.all(10),
                  color: const Color.fromARGB(250, 250, 252, 254),
                  elevation: 10,
                  shadowColor: const Color.fromARGB(250, 231, 241, 251),
                  child: Container(
                    height: 60,
                    margin: const EdgeInsets.all(10),
                    child: TextButton.icon(
                        icon: const Icon(
                          Icons.star_border,
                          color: Color.fromARGB(250, 74, 185, 255),
                        ),
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(120, 60)),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const LocationPage();
                          }));
                        },
                        label: const Text(
                          '我的收藏',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        )),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.all(10),
                  color: const Color.fromARGB(250, 250, 252, 254),
                  elevation: 10,
                  shadowColor: const Color.fromARGB(250, 231, 241, 251),
                  child: Container(
                      margin: const EdgeInsets.all(10),
                      child: TextButton.icon(
                        icon: const Icon(Icons.account_balance_wallet_outlined),
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(120, 60)),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const LocationPage();
                          }));
                        },
                        label: const Text('钱包余额',
                            style: TextStyle(
                              color: Colors.black,
                            )),
                      )),
                ),
                const Padding(padding: EdgeInsets.all(10)),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.all(10),
                  color: const Color.fromARGB(250, 250, 252, 254),
                  elevation: 10,
                  shadowColor: const Color.fromARGB(250, 231, 241, 251),
                  child: Container(
                      margin: const EdgeInsets.all(10),
                      child: TextButton.icon(
                        icon: const Icon(Icons.support_agent_outlined),
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(120, 60)),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const LocationPage();
                          }));
                        },
                        label: const Text('客服中心',
                            style: TextStyle(
                              color: Colors.black,
                            )),
                      )),
                ),
              ],
            ),
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  const Padding(padding: EdgeInsets.all(10)),
                  const SizedBox(
                    child: Text(
                      "我创建的文件夹",
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(60)),
                  SizedBox(
                    height: 48,
                    width: 48,
                    child: TextButton.icon(
                      onPressed: () {},
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)))),
                      label: const Text(""),
                      icon: const Icon(Icons.add,),
                      // child:  const Text("圆角"),
                    ),
                  ),
                  SizedBox(
                    height: 48,
                    width: 48,
                    child: TextButton.icon(
                      onPressed: () {},
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)))),
                      label: const Text(""),
                      icon: const Icon(Icons.list,),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
