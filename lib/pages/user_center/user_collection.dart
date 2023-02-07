import 'package:flutter/material.dart';
class UserCollPage extends StatefulWidget {
  const UserCollPage({Key? key}) : super(key: key);

  @override
  State<UserCollPage> createState() => _UserCollPageState();
}

class _UserCollPageState extends State<UserCollPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Collections",style: TextStyle(
      fontWeight: FontWeight.w900,fontSize: 20,
      ),),),
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
                leading: Icon(Icons.currency_exchange,color: Colors.greenAccent[400],size: 40,),
                title: const Text("出发点：广州",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),),
                subtitle: const Text("终点站：上海",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),),
                trailing: const Text("预计消费50元",style: TextStyle(
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
                leading: Icon(Icons.currency_exchange,color: Colors.greenAccent[400],size: 40,),
                title: const Text("出发点：广州",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),),
                subtitle: const Text("终点站：上海",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),),
                trailing: const Text("预计消费50元",style: TextStyle(
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
                leading: Icon(Icons.currency_exchange,color: Colors.greenAccent[400],size: 40,),
                title: const Text("出发点：广州",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),),
                subtitle: const Text("终点站：上海",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),),
                trailing: const Text("预计消费50元",style: TextStyle(
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
                leading: Icon(Icons.currency_exchange,color: Colors.greenAccent[400],size: 40,),
                title: const Text("出发点：广州",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),),
                subtitle: const Text("终点站：上海",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),),
                trailing: const Text("预计消费50元",style: TextStyle(
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
                leading: Icon(Icons.currency_exchange,color: Colors.greenAccent[400],size: 40,),
                title: const Text("出发点：广州",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),),
                subtitle: const Text("终点站：上海",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),),
                trailing: const Text("预计消费50元",style: TextStyle(
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
                leading: Icon(Icons.currency_exchange,color: Colors.greenAccent[400],size: 40,),
                title: const Text("出发点：广州",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),),
                subtitle: const Text("终点站：上海",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),),
                trailing: const Text("预计消费50元",style: TextStyle(
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
                leading: Icon(Icons.currency_exchange,color: Colors.greenAccent[400],size: 40,),
                title: const Text("出发点：广州",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),),
                subtitle: const Text("终点站：上海",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),),
                trailing: const Text("预计消费50元",style: TextStyle(
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
                leading: Icon(Icons.currency_exchange,color: Colors.greenAccent[400],size: 40,),
                title: const Text("出发点：广州",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),),
                subtitle: const Text("终点站：上海",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),),
                trailing: const Text("预计消费50元",style: TextStyle(
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
                leading: Icon(Icons.currency_exchange,color: Colors.greenAccent[400],size: 40,),
                title: const Text("出发点：广州",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),),
                subtitle: const Text("终点站：上海",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),),
                trailing: const Text("预计消费50元",style: TextStyle(
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
