import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({Key? key}) : super(key: key);

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
   DateTime dateTime = DateTime(2023, 2, 4);
   List pickerChildren = [
     "男",
     "女",
     "保密",
   ];
   int selectedValue = 0;
  void _changeBirthState() {
      DatePicker.showDatePicker(context,
          dateFormat: "yyyy年 MM月 dd日", //通过空格设置滚轮数量
          pickerTheme: const DateTimePickerTheme(
            backgroundColor: Colors.white,
              itemTextStyle: TextStyle(
                fontWeight: FontWeight.bold
              ),
              //样式设置，可以设置确认按钮、取消按钮、标题等
              cancel: Text("取消",style: TextStyle(fontSize: 14, color: Colors.blueAccent,fontWeight:FontWeight.w900)),
              confirm:
              Text("确认",
                  style: TextStyle(fontSize: 14, color: Colors.blueAccent,fontWeight:FontWeight.w900))),
          onConfirm: (dateTimes, selectedIndex) {
            setState((){
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
                         child: const Text("取消",style:TextStyle(fontSize: 14, color: Colors.blueAccent,fontWeight:FontWeight.w900),),
                       ),
                       TextButton(
                         onPressed: () {
                           Navigator.pop(context, controller.selectedItem);
                         },
                         child:const Text("确认",style: TextStyle(fontSize: 14, color: Colors.blueAccent,fontWeight:FontWeight.w900)),
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
                     child: Container(
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
                           print("value = $value, 性别：${pickerChildren[value]}");
                         },
                         children: pickerChildren.map((data) {
                           return Center(
                             child: Text(data,style: const TextStyle(fontWeight: FontWeight.bold
                             ),),
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
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),

      // backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("个人中心",style: TextStyle(
          fontWeight: FontWeight.w900,fontSize: 20,
        ),),
      ),
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 10,),
          Card(
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
                  title: Text("头像"),
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
                const ListTile(
                  title: Text("姓名: cdw"),
                ),

               const Divider(),
                const SizedBox(height: 10,),
                Row(
                  children:   [
                const Text(
                      "    性别:  ",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                GestureDetector(
                 onTap: _didClickSelectedGender,
                 child: Text("${pickerChildren[selectedValue]}",style: const TextStyle(
                   fontSize: 16,color: Colors.blue
                 ),),
                )
                  ],
                ),
                const SizedBox(height: 10,),
                const Divider(),
                Column(
                  children: [
                    SizedBox(
                      child: Row(
                        children: [
                          const Text(
                            "    出生日期:",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          CupertinoButton(
                              onPressed: _changeBirthState,
                              child:
                              Text('$dateTime'.toString().substring(0,10))),

                        ],
                      ),
                    )
                  ],
                ),
                const Divider(),
                const ListTile(
                  title: Text("个性签名: 不知道写什么东西进去"),
                ),
              ],
            ),
          ),
          // 这段做账号绑定
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.all(5),
            color: Colors.white,
            shadowColor: Colors.white10,
            elevation: 10,
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

        ],
      ),
    );
  }
}
