import 'dart:async';
import 'dart:io';

import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';
import 'package:flutter/material.dart';
import 'package:jtjs/pages/user_center/user_assistant.dart';
import 'package:jtjs/pages/user_center/user_collection.dart';
import 'package:jtjs/pages/user_center/user_history.dart';
import 'package:jtjs/pages/user_center/user_message.dart';
import 'package:jtjs/pages/user_center/user_wallet.dart';
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
      backgroundColor: const Color.fromARGB(250, 242, 243, 247),
      // backgroundColor: const Color.fromARGB(250, 239, 249, 255),
      appBar: AppBar(
        // centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 166, 211, 242),
        // backgroundColor: Colors.lightBlueAccent,
        // shadowColor: Colors.white,
        // elevation: 0,
        // leading: Icon(Icons.arrow_back_outlined),
        title: const Text('智慧公交——主页',
          style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w900,
          color: Colors.black,
            // fontFamily: "宋体"
        ),
        ),
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
            color: const Color.fromARGB(232,175, 195, 168),
            // elevation: 10,
            // shadowColor: Colors.grey,
            child: Container(
              height: 120,
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
                          fontWeight: FontWeight.w900,
                          fontSize: 26,
                          // color: Color.fromARGB(250, 155, 117, 24),
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(30)),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const UserMessPage()));
                        },
                        icon: const Icon(Icons.chat_outlined))
                  ]),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          //包括历史记录和收藏
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: const EdgeInsets.all(10),
                color: const Color.fromARGB(250, 250, 252, 254),
                // color: const Color.fromARGB(250, 242, 243, 247),
                elevation: 10,
                // shadowColor: const Color.fromARGB(a, r, g, b),
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
                              return const UserHisPage();
                            }));
                      },
                      label: const Text(
                        '历史记录',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
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
                      ),
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(120, 60)),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return const UserCollPage();
                            }));
                      },
                      label: const Text(
                        '我的收藏',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      )),
                ),
              ),
            ],
          ),
          //包括钱包余额和客服中心
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
                              return const UserWallPage();
                            }));
                      },
                      label: const Text(
                        '钱包余额',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
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
                    margin: const EdgeInsets.all(10),
                    child: TextButton.icon(
                      icon: const Icon(Icons.support_agent_outlined),
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(120, 60)),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return const UserAssistPage();
                            }));
                      },
                      label: const Text(
                        '客服中心',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    )),
              ),
            ],
          ),
          Container(
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(20),
            // ),
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            // color: const Color.fromARGB(250, 250, 252, 254),
            // elevation: 10,
            // shadowColor: const Color.fromARGB(250, 231, 241, 251),
            child: Row(
              children: [
                const Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0)),
                const Expanded(flex:10,child:SizedBox(
                  child: Text(
                    "我创建的文件夹",
                    style:
                    TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
                  ),
                ),),
                const Expanded( flex: 10,child: SizedBox(
                  width: 90,
                  height: 10,
                )),

                Expanded(
                    flex: 8,
                    child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      color: Colors.blueAccent,
                      icon: const Icon(
                        Icons.add,
                      ),
                      // child:  const Text("圆角"),
                    ),
                    IconButton(
                      onPressed: () {},
                      color: Colors.blueAccent,
                      icon: const Icon(
                        Icons.list,
                      ),
                    ),
                  ],
                ))
              ],
            ),
          ),
          //文件夹内容（目前是循环体）
          Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 2.0,
                      color: const Color.fromARGB(250, 221, 221, 221)),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const ListTile(
                  leading: Icon(Icons.system_update_tv_outlined),
                  title: Text(
                    "南京市",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text("5个"),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 2.0,
                      color: const Color.fromARGB(250, 221, 221, 221)),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const ListTile(
                  leading: Icon(Icons.system_update_tv_outlined),
                  title: Text(
                    "南京市",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text("5个"),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 2.0,
                      color: const Color.fromARGB(250, 221, 221, 221)),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const ListTile(
                  leading: Icon(Icons.system_update_tv_outlined),
                  title: Text(
                    "南京市",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text("5个"),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 2.0,
                      color: const Color.fromARGB(250, 221, 221, 221)),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const ListTile(
                  leading: Icon(Icons.system_update_tv_outlined),
                  title: Text(
                    "南京市",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text("5个"),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 2.0,
                      color: const Color.fromARGB(250, 221, 221, 221)),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const ListTile(
                  leading: Icon(Icons.system_update_tv_outlined),
                  title: Text(
                    "南京市",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text("5个"),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 2.0,
                      color: const Color.fromARGB(250, 221, 221, 221)),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const ListTile(
                  leading: Icon(Icons.system_update_tv_outlined),
                  title: Text(
                    "南京市",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text("5个"),
                ),
              ),
            ],
          )

          // )
          // ),
        ],
      )
      ),
    );
  }
}
