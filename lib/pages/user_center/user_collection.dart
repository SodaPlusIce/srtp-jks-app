import 'package:flutter/material.dart';
import 'package:jtjs/config/appbar_settings.dart';
class UserCollPage extends StatefulWidget {
  const UserCollPage({Key? key}) : super(key: key);

  @override
  State<UserCollPage> createState() => _UserCollPageState();
}

class _UserCollPageState extends State<UserCollPage> {
  Column _showCollectionMessages(start,stop){
    return Column(
      children: [
        /*const SizedBox(height: 10,),
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
            child:  ListTile(
              leading: Icon(Icons.currency_exchange,color: Colors.greenAccent[400],size: 40,),
              title:  Text("出发点:$start",style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),),
              subtitle:  Text("终点站:$stop",style:const TextStyle(
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
        ),*/
        ListTile(
          leading: const Icon(Icons.currency_exchange,color: Color.fromARGB(250, 42, 173, 103), size: 40,),
          title:  Text("出发点:$start",style: const TextStyle(
            fontSize: 18,
            fontFamily: "oppoSansRegular",
            // fontWeight: FontWeight.w700,
            color: Colors.black,
          ),),
          subtitle:  Text("终点站:$stop",style:const TextStyle(
            fontSize: 18,
            fontFamily: "oppoSansRegular",
            // fontWeight: FontWeight.w700,
            color: Colors.black,
          ),),

          trailing: const Text("预计消费50元",style: TextStyle(
            fontSize: 23,
            fontFamily: "oppoSansMedium",
            // fontWeight: FontWeight.w900,
            color: Colors.black,
          ),),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UnionAppBar(title: "收藏",),
      backgroundColor:  const Color.fromARGB(250, 245, 245, 245),
      body: ListView.builder(
        itemCount: 5,
          itemBuilder: (context,index){
          return _showCollectionMessages("广州", "上海");
      })
    );
  }
}
