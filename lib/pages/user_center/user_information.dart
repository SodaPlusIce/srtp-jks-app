import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({Key? key}) : super(key: key);

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  List<int> _selectedIndex=[123,1,5];
  DateTime dateTime = DateTime(2023, 2, 4);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("个人中心"),
      ),
      body: ListView(
        children: <Widget>[
          // 这段做账号绑定

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.all(5),
            color: Colors.white60,
            shadowColor: Colors.white12,
            elevation: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                ListTile(
                  title: Text("系统账号: 123456789"),
                ),
                Divider(),
                ListTile(
                  title: Text("手机号:15901013972"),
                ),
              ],
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.all(5),
            color: Colors.white60,
            shadowColor: Colors.white12,
            elevation: 20,
            child: Column(
              children: [
                // 这段做个人信息内容
                ListTile(
                  title: Text("姓名: cdw"),
                ),

                Divider(),
                Row(
                  children: [
                      Text("    性别:",style: TextStyle(
                        fontSize: 16,
                      ),),
                  ],
                ),

                Divider(),
                Column(
                  children: [
                    SizedBox(
                      child:
                      Row(
                        children: [
                          Text("    出生日期:",style: TextStyle(
                            fontSize: 16,
                          ),) ,
                          CupertinoButton(
                              onPressed: () {
                                DatePicker.showDatePicker(context,
                                    dateFormat: "yyyy年 MM月 dd日", //通过空格设置滚轮数量
                                    pickerTheme: const DateTimePickerTheme(
                                      //样式设置，可以设置确认按钮、取消按钮、标题等
                                        confirm: Text("确认",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.blue))), onConfirm:
                                        ( dateTime, selectedIndex) {
                                  _selectedIndex = selectedIndex;
                                      // 确认按钮回调，获取选择结果 dateTime
                                    }
                                    );
                              },
                            child:Text((new DateTime(_selectedIndex[0]+1900,_selectedIndex[1]+1,_selectedIndex[2]+1)).toString()) ,)
                        ],
                      ),
                    )




                  ],
                ),

                Divider(),
                ListTile(
                  title: Text("个性签名: 不知道写什么东西进去"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
