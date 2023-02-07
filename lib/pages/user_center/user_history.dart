import 'package:flutter/material.dart';
class UserHisPage extends StatefulWidget {
  const UserHisPage({Key? key}) : super(key: key);

  @override
  State<UserHisPage> createState() => _UserHisPageState();
}

class _UserHisPageState extends State<UserHisPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Histories",style: TextStyle(
        fontWeight: FontWeight.w900,fontSize: 20,)),),
      backgroundColor:  const Color.fromARGB(250, 239, 249, 255),
      body: ListView(
        children: [
          const SizedBox(height: 10,),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            color: const Color.fromARGB(250, 250, 252, 254),
            elevation: 10,
            shadowColor: const Color.fromARGB(250, 231, 241, 251),
            child: Container(
                margin: const EdgeInsets.all(10),
                child:  ListTile(
                  leading: Icon(Icons.bus_alert,color: Colors.greenAccent[400],size: 40,),
                title: const Text("出发点：南京",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),),
                subtitle: const Text("终点站：北京",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),),
                  trailing: const Text("共消费200元",style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),),
                ),
          ),
    ),
          const Divider(),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            color: const Color.fromARGB(250, 250, 252, 254),
            elevation: 10,
            shadowColor: const Color.fromARGB(250, 231, 241, 251),
            child: Container(
              margin: const EdgeInsets.all(10),
              child:  ListTile(
                leading: Icon(Icons.bus_alert,color: Colors.greenAccent[400],size: 40,),
                title: const Text("出发点：南京",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),),
                subtitle: const Text("终点站：北京",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),),
                trailing: const Text("共消费200元",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),),
              ),
            ),
          ),
          const Divider(),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            color: const Color.fromARGB(250, 250, 252, 254),
            elevation: 10,
            shadowColor: const Color.fromARGB(250, 231, 241, 251),
            child: Container(
              margin: const EdgeInsets.all(10),
              child:  ListTile(
                leading: Icon(Icons.bus_alert,color: Colors.greenAccent[400],size: 40,),
                title: const Text("出发点：南京",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),),
                subtitle: const Text("终点站：北京",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),),
                trailing: const Text("共消费200元",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),),
              ),
            ),
          ),
          const Divider(),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            color: const Color.fromARGB(250, 250, 252, 254),
            elevation: 10,
            shadowColor: const Color.fromARGB(250, 231, 241, 251),
            child: Container(
              margin: const EdgeInsets.all(10),
              child:  ListTile(
                leading: Icon(Icons.bus_alert,color: Colors.greenAccent[400],size: 40,),
                title: const Text("出发点：南京",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),),
                subtitle: const Text("终点站：北京",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),),
                trailing: const Text("共消费200元",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),),
              ),
            ),
          ),
          const Divider(),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            color: const Color.fromARGB(250, 250, 252, 254),
            elevation: 10,
            shadowColor: const Color.fromARGB(250, 231, 241, 251),
            child: Container(
              margin: const EdgeInsets.all(10),
              child:  ListTile(
                leading: Icon(Icons.bus_alert,color: Colors.greenAccent[400],size: 40,),
                title: const Text("出发点：南京",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),),
                subtitle: const Text("终点站：北京",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),),
                trailing: const Text("共消费200元",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),),
              ),
            ),
          ),
          const Divider(),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            color: const Color.fromARGB(250, 250, 252, 254),
            elevation: 10,
            shadowColor: const Color.fromARGB(250, 231, 241, 251),
            child: Container(
              margin: const EdgeInsets.all(10),
              child:  ListTile(
                leading: Icon(Icons.bus_alert,color: Colors.greenAccent[400],size: 40,),
                title: const Text("出发点：南京",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),),
                subtitle: const Text("终点站：北京",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),),
                trailing: const Text("共消费200元",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),),
              ),
            ),
          ),
          const Divider(),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            color: const Color.fromARGB(250, 250, 252, 254),
            elevation: 10,
            shadowColor: const Color.fromARGB(250, 231, 241, 251),
            child: Container(
              margin: const EdgeInsets.all(10),
              child:  ListTile(
                leading: Icon(Icons.bus_alert,color: Colors.greenAccent[400],size: 40,),
                title: const Text("出发点：南京",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),),
                subtitle: const Text("终点站：北京",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),),
                trailing: const Text("共消费200元",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),),
              ),
            ),
          ),
          const Divider(),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            color: const Color.fromARGB(250, 250, 252, 254),
            elevation: 10,
            shadowColor: const Color.fromARGB(250, 231, 241, 251),
            child: Container(
              margin: const EdgeInsets.all(10),
              child:  ListTile(
                leading: Icon(Icons.bus_alert,color: Colors.greenAccent[400],size: 40,),
                title: const Text("出发点：南京",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),),
                subtitle: const Text("终点站：北京",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),),
                trailing: const Text("共消费200元",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),),
              ),
            ),
          ),
          const Divider(),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            color: const Color.fromARGB(250, 250, 252, 254),
            elevation: 10,
            shadowColor: const Color.fromARGB(250, 231, 241, 251),
            child: Container(
              margin: const EdgeInsets.all(10),
              child:  ListTile(
                leading: Icon(Icons.bus_alert,color: Colors.greenAccent[400],size: 40,),
                title: const Text("出发点：南京",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),),
                subtitle: const Text("终点站：北京",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),),
                trailing: const Text("共消费200元",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),),
              ),
            ),
          ),

        ],

    ),
    );
  }
}
