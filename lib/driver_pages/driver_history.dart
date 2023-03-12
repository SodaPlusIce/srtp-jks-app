import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:jtjs/config/appbar_settings.dart';

import '../../config/config.dart';

class DriverHisPage extends StatefulWidget {
  const DriverHisPage({Key? key}) : super(key: key);

  @override
  State<DriverHisPage> createState() => _DriverHisPageState();
}

class _DriverHisPageState extends State<DriverHisPage> {
  List<List<String>> item = [];
  int len = 0;
  Column _showHistoryMessages(start, stop, time,passengers) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: ListTile(
            leading: const Icon(
              Icons.bus_alert,
              color: Color.fromARGB(250, 42, 173, 103),
              size: 40,
            ),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "出发站:$start\n" "终点站:$stop",
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: "oppoSansRegular",
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
            trailing:  Text(
              "共消费$passengers元",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 23,
                fontFamily: "oppoSansMedium",
                color: Colors.black,

              ),
            ),
          ),
        )
      ],
    );
  }

  /// 调用接口： getOrderInfo
  Future<void> getOrderInfo() async {
    String url = "${ConstConfig.netip}/getHistoryOrderInfo";
    print("666666$url");
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      //由于后端传回来的数据为utf-8编码，因此需要对其进行转换数据格式
      List arrs = convert.jsonDecode(res.body);
      print("666666$arrs");
      //   print(arrs[0]);
      //   print(arrs[0][0]);
      len = arrs.length;
      for (var i = 0; i < len; i++) {
        var times = arrs[i][0].toString().substring(4, 16);
        item.add([
          arrs[i][3],
          arrs[i][4],
          "${times.substring(0, 4)}-${times.substring(4, 6)}-${times.substring(6, 8)}",
          arrs[i][7].toString()
        ]);
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
        appBar: UnionAppBar(
          title: "历史记录",
        ),
        backgroundColor: const Color.fromARGB(250, 245, 245, 245),
        body: ListView.builder(
            itemCount: item.length,
            itemBuilder: (context, index) {
              // print("index是$index");
              return _showHistoryMessages(item[index][0], item[index][1],item[index][2],item[index][3]);
            }));
  }
}
