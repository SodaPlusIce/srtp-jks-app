import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:jtjs/config/appbar_settings.dart';
import 'package:jtjs/config/color.dart';
import 'package:jtjs/pages/user_center/user_assistant.dart';

import 'package:jtjs/pages/user_center/user_message.dart';


class DriverCenterPage extends StatefulWidget {
  const DriverCenterPage({Key? key}) : super(key: key);

  @override
  State<DriverCenterPage> createState() => _DriverCenterPageState();
}

class _DriverCenterPageState extends State<DriverCenterPage> {
  DateTime dateTime = DateTime(2023, 2, 4);
  List pickerChildren = [
    "男",
    "女",
    "保密",
  ];
  int selectedValue = 0;
  var unionTextStyle =
  const TextStyle(fontFamily: "oppoSansMedium", fontSize: 16);
  var unionSubtitleTextStyle =
  const TextStyle(fontFamily: "oppoSansBold", fontSize: 18);

  void _changeBirthState() {
    DatePicker.showDatePicker(context,
        dateFormat: "yyyy年 MM月 dd日", //通过空格设置滚轮数量
        pickerTheme: const DateTimePickerTheme(
            backgroundColor: Colors.white,
            itemTextStyle: TextStyle(fontWeight: FontWeight.bold),
            //样式设置，可以设置确认按钮、取消按钮、标题等
            cancel: Text("取消",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w900)),
            confirm: Text("确认",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w900))),
        onConfirm: (dateTimes, selectedIndex) {
          setState(() {
            dateTime = dateTimes;
          });
          // 确认按钮回调，获取选择结果 dateTime
        });
  }

  void _didClickSelectedGender() {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          var controller =
          FixedExtentScrollController(initialItem: selectedValue);
          return Container(
            // padding: EdgeInsets.all(10),
            height: 250,
            color: Colors.grey[200],
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 40,
                  // color: Colors.grey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "取消",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, controller.selectedItem);
                        },
                        child: const Text("确认",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.w900)),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 22,
                    ),
                    child: SizedBox(
                      height: 200,
                      child: CupertinoPicker(
                        scrollController: controller,
                        // diameterRatio: 1.5,
                        // offAxisFraction: 0.2, //轴偏离系数
                        // useMagnifier: true, //使用放大镜
                        // magnification: 1.5, //当前选中item放大倍数
                        itemExtent: 32, //行高
                        // backgroundColor: Colors.amber, //选中器背景色
                        onSelectedItemChanged: (value) {
                          // print("value = $value, 性别：${pickerChildren[value]}");
                        },
                        children: pickerChildren.map((data) {
                          return Center(
                            child: Text(
                              data,
                              style:
                              const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }).then((value) {
      if (value != selectedValue && value != null) {
        setState(() {
          selectedValue = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(250, 245, 245, 245),
      // backgroundColor: const Color.fromARGB(250, 239, 249, 255),
      appBar: UnionAppBar(
        title: "个人中心",
        // colors: Colors.white,
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
                color:   Colors.white38,
                elevation: 0,
                // shadowColor: Colors.grey,
                child: SizedBox(
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
                            /*Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UserInfoPage()));*/
                          },
                          child: const Text(
                            "zcc",
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
                                      builder: (context) => const UserMessPage()));
                            },
                            icon: const Icon(Icons.chat_outlined))
                      ]),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  height: 40,
                  child: Row(
                    children:  [
                      const SizedBox(
                        width: 14,
                      ),
                      Text(
                        "基本信息",
                        style: unionSubtitleTextStyle,
                      ),
                    ],
                  )),
              Column(
                children: [
                  // 这段做个人信息内容
                  ListTile(
                    title: Text(
                      "姓名: zcc",
                      style: unionTextStyle,
                    ),
                  ),
                  ListTile(
                    title:   Row(
                      children: [
                        Text(
                          "性别:  ",
                          style: unionTextStyle,
                        ),
                        GestureDetector(
                          onTap: _didClickSelectedGender,
                          child: Text(
                            "${pickerChildren[selectedValue]}",
                            style: unionTextStyle,
                          ),
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    title: Column(
                      children: [
                        SizedBox(
                          child: Row(
                            children: [
                              Text(
                                "出生日期:",
                                style: unionTextStyle,
                              ),
                              CupertinoButton(
                                  onPressed: _changeBirthState,
                                  child: Text(
                                      '$dateTime'.toString().substring(0, 10))),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "个性签名: 东南大学智慧交通司机端",
                      style: unionTextStyle,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "系统账号: 123456789",
                      style: unionTextStyle,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "手机号:15901013972",
                      style: unionTextStyle,
                    ),
                  ),
                ],
              ),
              SizedBox(
                  height: 40,
                  child: Row(
                    children:  [
                      const SizedBox(
                        width: 14,
                      ),
                      Text(
                        "帮助",
                        style: unionSubtitleTextStyle,
                      ),
                    ],
                  )),
              Column(
                children:  [
                  ListTile(
                    leading: const Icon(Icons.feedback_outlined),
                    title:  Text(
                      "联系客服",
                      style: unionTextStyle,
                    ),
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>const UserAssistPage()));
                    },
                    trailing: const Icon(
                      Icons.chevron_right,
                    ),
                  ),


                ],
              ),
              SizedBox(
                  height: 40,
                  child: Row(
                    children:  [
                      const SizedBox(
                        width: 14,
                      ),
                      Text(
                        "关于",
                        style: unionSubtitleTextStyle,
                      ),
                    ],
                  )),

              Column(
                children:  [
                  ListTile(
                    leading:const Icon(Icons.mode_comment_outlined),
                    title: Text(
                      "在Google Play上评分",
                      style: unionTextStyle,
                    ),
                    trailing:const Icon(Icons.chevron_right),
                  ),
                  ListTile(
                    leading:const Icon(Icons.share),
                    title: Text(
                      "分享给朋友",
                      style: unionTextStyle,
                    ),
                    trailing:const Icon(Icons.chevron_right),
                  ),
                  ListTile(
                    leading:const Icon(Icons.more_horiz),
                    title: Text(
                      "更多",
                      style: unionTextStyle,
                    ),
                    trailing: const Icon(Icons.chevron_right),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
