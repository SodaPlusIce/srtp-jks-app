import 'package:flutter/material.dart';
import 'package:jtjs/pages/user_center/user_assistant.dart';
import 'package:jtjs/pages/user_center/user_collection.dart';
import 'package:jtjs/pages/user_center/user_wallet.dart';
class UserMessPage extends StatefulWidget {
  const UserMessPage({Key? key}) : super(key: key);

  @override
  State<UserMessPage> createState() => _UserMessPageState();
}

class _UserMessPageState extends State<UserMessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Messages",style: TextStyle(
        fontWeight: FontWeight.w900,fontSize: 20,
      ),),),
      backgroundColor:  const Color.fromARGB(250, 239, 249, 255),
      body: ListView(
        children: [
          const SizedBox(height: 10,),
          
          //消费
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const UserWallPage()));
            },
            child: Card(
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
                  leading: Icon(Icons.money_off,color: Colors.redAccent[400],size: 40,),

                  trailing: const Text("您有一笔消费记录",style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),),
                ),
              ),
            ),
          ),
          const Divider(),
        //  充值
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const UserWallPage()));
            },
            child: Card(
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
                  leading: Icon(Icons.money_outlined,color: Colors.greenAccent[400],size: 40,),

                  trailing: const Text("您有一笔充值记录",style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),),
                ),
              ),
            ),
          ),
          const Divider(),
        //  提现
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const UserWallPage()));
            },
            child: Card(
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
                  leading: Icon(Icons.money_outlined,color: Colors.redAccent[400],size: 40,),

                  trailing: const Text("您有一笔提现记录",style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),),
                ),
              ),
            ),
          ),
          const Divider(),
        //  收藏
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const UserCollPage()));
            },
            child: Card(
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

                  trailing: const Text("您有一项收藏记录",style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),),
                ),
              ),
            ),
          ),
          const Divider(),
        //  回馈
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const UserAssistPage()));
            },
            child: Card(
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
                  leading: Icon(Icons.mic,color: Colors.blueAccent[400],size: 40,),

                  trailing: const Text("您有一条回馈信息",style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),),
                ),
              ),
            ),
          ),
          const Divider(),
        ],

      ),
    );
  }
}
