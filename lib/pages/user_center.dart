import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:jtjs/config/appbar_settings.dart';
import 'package:jtjs/config/color.dart';
import 'package:jtjs/pages/user_center/user_assistant.dart';

import 'package:jtjs/pages/user_center/user_message.dart';

import './user_center/user_information.dart';

class CenterPage extends StatefulWidget {
  const CenterPage({Key? key}) : super(key: key);

  @override
  State<CenterPage> createState() => _CenterPageState();
}

class _CenterPageState extends State<CenterPage> {
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
                                  builder: (context) => const UserMessPage()));
                        },
                        icon: const Icon(Icons.chat_outlined))
                  ]),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          /* Row(
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
          ),*/

          /*Row(
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
          ),*/
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
       /*   Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.all(5),
            color: Colors.white,
            shadowColor: Colors.white10,
            elevation: 20,
            child: Column(
              children: [
                // 这段做个人信息内容
                ListTile(
                  title: Text(
                    "头像",
                    style: unionTextStyle,
                  ),
                  trailing: ClipOval(
                    child: Image.asset(
                      'assets/images/lake.jpg',
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Divider(),
                ListTile(
                  title: Text(
                    "姓名: cdw",
                    style: unionTextStyle,
                  ),
                ),

                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "    性别:  ",
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
                const SizedBox(
                  height: 10,
                ),
                const Divider(),
                Column(
                  children: [
                    SizedBox(
                      child: Row(
                        children: [
                          Text(
                            "    出生日期:",
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
                const Divider(),
                ListTile(
                  title: Text(
                    "个性签名: 不知道写什么东西进去",
                    style: unionTextStyle,
                  ),
                ),
              ],
            ),
          ),*/
          Column(
            children: [
              // 这段做个人信息内容
              ListTile(
                title: Text(
                  "头像",
                  style: unionTextStyle,
                ),
                trailing: ClipOval(
                  child: Image.asset(
                    'assets/images/lake.jpg',
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  "姓名: cdw",
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
                  "个性签名: 不知道写什么东西进去",
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
          /*Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.all(5),
            color: Colors.white,
            shadowColor: Colors.white10,
            elevation: 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
          ),*/
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

          // 完整的条目
          /* Container(
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(20),
            // ),
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            // color: const Color.fromARGB(250, 250, 252, 254),
            // elevation: 10,
            // shadowColor: const Color.fromARGB(250, 231, 241, 251),
            child: Row(
              children: [
                const Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
                const Expanded(flex:10,child:SizedBox(
                  child: Text(
                    "我创建的文件夹",
                    style:
                    TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
                  ),
                ),),
                const Expanded( flex: 10,child: SizedBox(
                  width: 70,
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
          ),*/
          //文件夹内容（目前是循环体）
          /*Column(
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
          )*/

          // )
          // ),
        ],
      )),
    );
  }
}
