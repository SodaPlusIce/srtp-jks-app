import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:jtjs/config/appbar_settings.dart';

const String netip = "http://10.0.2.2:5000";

class DriverHisPage extends StatefulWidget {
  const DriverHisPage({Key? key}) : super(key: key);

  @override
  State<DriverHisPage> createState() => _DriverHisPageState();
}

class _DriverHisPageState extends State<DriverHisPage> {
  List<List<String>> item = [];
  int len = 0;
  Column _showHistoryMessages(start, stop, time) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          color: const Color.fromARGB(250, 250, 252, 254),
          // elevation: 10,
          // shadowColor: const Color.fromARGB(250, 231, 241, 251),
          child: Container(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: Icon(
                Icons.bus_alert,
                color: Colors.greenAccent[400],
                size: 40,
              ),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "出发站:$start\n""终点站:$stop",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              subtitle: Column(
                children: [
                  Text(
                    "$time",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              trailing: const Text(
                "共消费200元",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,

                ),
              ),
            ),
          ),
        )
      ],
    );
  }

/*  /// 调用接口： getOrderInfo
  Future<void> getOrderInfo() async {
    String url = "$netip/getOrderInfo";
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      print(res.body);
    } else {
      print("Failed to get data.~~~");
      // 做出提示，网络连接有问题
    }
  }*/
  /// 调用接口： getOrderInfo
  Future<void> getOrderInfo() async {
    String url = "$netip/getOrderInfo";
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      //由于后端传回来的数据为utf-8编码，因此需要对其进行转换数据格式
      List arrs = convert.jsonDecode(res.body);
      /* print(arrs);
        print(arrs[0]);
        print(arrs[0][0]);*/
      len = arrs.length;
      for (var i = 0; i < len; i++) {
        var times=arrs[i][0].toString().substring(4,14);
        item.add([arrs[i][1], arrs[i][2],"${times.substring(0,4)}-${times.substring(4,6)}-${times.substring(6,8)}-${times.substring(8,10)}"]);
      }
      // 对页面进行刷新
      setState(() {});
    } else {
      print("Failed to get data.~~~");
      // 做出提示，网络连接有问题
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getOrderInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: UnionAppBar(title: "历史记录",),
        backgroundColor: const Color.fromARGB(250, 245, 245, 245),
        body: ListView.builder(
            itemCount: item.length,
            itemBuilder: (context, index) {
              // print("index是$index");
              return _showHistoryMessages(item[index][0], item[index][1],item[index][2]);
            }));
  }
}
