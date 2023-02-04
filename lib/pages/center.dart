import 'dart:async';
import 'dart:io';

import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';
import 'package:flutter/material.dart';
import '../config/config.dart';
import 'package:permission_handler/permission_handler.dart';

import './location.dart';

class CenterPage extends StatefulWidget {
  const CenterPage({Key? key}) : super(key: key);

  @override
  State<CenterPage> createState() => _CenterPageState();
}

class _CenterPageState extends State<CenterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: Icon(Icons.arrow_back_outlined),
        title: const Text('智能公交——预约响应'),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(40),
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
                    const Text(
                      "cdw",
                      style: TextStyle(fontSize: 20),
                    ),
                    const Padding(padding: EdgeInsets.all(30)),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.chat_outlined))
                  ]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: const EdgeInsets.all(10),
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.history),
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(120, 60)),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const LocationPage();
                        }));
                      },
                      label: const Text('历史记录'),
                    )),
                Container(
                    margin: const EdgeInsets.all(10),
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.star_border),
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(120, 60)),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const LocationPage();
                        }));
                      },
                      label: const Text('我的收藏'),
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: const EdgeInsets.all(10),
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.account_balance_wallet_outlined),
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(120, 60)),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const LocationPage();
                        }));
                      },
                      label: const Text('钱包余额'),
                    )),
                Container(
                    margin: const EdgeInsets.all(10),
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.support_agent_outlined),
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(120, 60)),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const LocationPage();
                        }));
                      },
                      label: const Text('客服中心'),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
