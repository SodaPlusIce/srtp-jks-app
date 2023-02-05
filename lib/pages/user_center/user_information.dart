import 'package:flutter/material.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({Key? key}) : super(key: key);

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("个人中心"),
      ),
      body: ListView(
        children: const <Widget>[
          ListTile(
            leading: Icon(Icons.home),
            title: Text("主页"),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.assessment,
              color: Colors.red,
            ),
            title: Text("aaa"),
            trailing: Icon(Icons.keyboard_arrow_right_rounded),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.payment,
              color: Colors.green,
            ),
            title: Text("bbb"),
            trailing: Icon(Icons.keyboard_arrow_right_rounded),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.local_car_wash,
              color: Colors.orange,
            ),
            title: Text("ccc"),
            trailing: Icon(Icons.keyboard_arrow_right_rounded),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.favorite,
              color: Colors.lightGreen,
            ),
            title: Text("ddd"),
            trailing: Icon(Icons.keyboard_arrow_right_rounded),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.people,
              color: Colors.black54,
            ),
            title: Text("eee"),
            trailing: Icon(Icons.keyboard_arrow_right_rounded),
          ),
          Divider(),
        ],
      ),
    );
  }
}
