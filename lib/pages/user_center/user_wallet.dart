import 'package:flutter/material.dart';
import 'package:jtjs/config/appbar_settings.dart';
class UserWallPage extends StatefulWidget {
  const UserWallPage({Key? key}) : super(key: key);

  @override
  State<UserWallPage> createState() => _UserWallPageState();
}

class _UserWallPageState extends State<UserWallPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UnionAppBar(title: "钱包余额",),
      backgroundColor:  const Color.fromARGB(250, 245, 245, 245),
      body: ListView(
        children: [
          //明细
          Row(
            children: const [
              Padding(padding: EdgeInsets.all(10)),
              SizedBox(
                child: Text(
                  "明细:",
                  style:
                  TextStyle(
                    fontFamily: "oppoSansMedium",
                      // fontWeight: FontWeight.w900,
                      fontSize: 16),
                ),
              ),
              SizedBox(width: 90),

            ],
          ),
          const SizedBox(height: 10,),
          Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                // color: const Color.fromARGB(250, 255, 255, 255),
                 color:  Colors.greenAccent[400],
                 borderOnForeground: false,
                 elevation: 0,
                // elevation: 10,
                // shadowColor: const Color.fromARGB(250, 231, 241, 251),
                child: Container(
                  height: 200,
                  width: 500,
                  margin: const EdgeInsets.all(10),
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      ListTile(
                        // leading: Icon(Icons.monetization_on_outlined,color: Colors.greenAccent[400],size: 40,),
                        title: Text("余额:",style: TextStyle(
                          fontSize: 35,
                          // fontWeight: FontWeight.w600,
                          fontFamily: "oppoSansBold",
                          color: Colors.white,
                        ),),
                        trailing: Text("2000元",style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),),
                      ),
                      Divider(height: 50,),
                      ListTile(
                        // leading: Icon(Icons.money_off,color: Colors.redAccent[400],size: 40,),
                        title: Text("消费:",style: TextStyle(
                          fontSize: 35,
                          fontFamily: "oppoSansBold",

                          color: Colors.white,
                        ),),
                        trailing: Text("5500元",style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),),
                      )
                    ],
                  ),
                ),
              ),
          //操作
          const Divider(),

          Row(
            children: const [
              Padding(padding: EdgeInsets.all(10)),
              SizedBox(
                child: Text(
                  "操作:",
                  style:
                  TextStyle(
                      fontFamily: "oppoSansMedium",
                      // fontWeight: FontWeight.w900,
                      fontSize: 16),
                ),
              ),
              SizedBox(width: 90),

            ],
          ),
          const SizedBox(height: 10,),
          Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      color: const Color.fromARGB(250, 255, 255, 255),
                      borderOnForeground: false,
                      elevation: 0,
                      // shadowColor: const Color.fromARGB(250, 231, 241, 251),
                      child:Column(
                        children: [
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                             /* Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                color: const Color.fromARGB(250, 255, 255, 255),
                                // elevation: 10,
                                // shadowColor: const Color.fromARGB(250, 231, 241, 251),
                                child: Container(
                                    margin: const EdgeInsets.all(10),
                                    child: TextButton.icon(
                                      icon: const Icon(Icons.money,size: 40,color: Color.fromARGB(250, 42, 173, 103),),
                                      style: ElevatedButton.styleFrom(
                                          fixedSize: const Size(120, 60)),
                                      onPressed: () {
                                      },
                                      label: const Text(
                                        '充值',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: "oppoSansBold",
                                          // fontWeight: FontWeight.w900,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )),
                              ),*/
                              Container(
                                  margin: const EdgeInsets.all(10),
                                  child: TextButton.icon(
                                    icon: const Icon(Icons.money,size: 40,color: Color.fromARGB(250, 42, 173, 103),),
                                    style: ElevatedButton.styleFrom(
                                        fixedSize: const Size(120, 60)),
                                    onPressed: () {
                                    },
                                    label: const Text(
                                      '充值',
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontFamily: "oppoSansBold",
                                        // fontWeight: FontWeight.w900,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )),
                              const SizedBox(width: 40,),
                              Container(
                                  margin: const EdgeInsets.all(10),
                                  child: TextButton.icon(
                                    icon:const  Icon(Icons.money_outlined,size: 40,color:  Color.fromARGB(250, 233, 46, 75),),
                                    style: ElevatedButton.styleFrom(
                                        fixedSize: const Size(120, 60)),
                                    onPressed: () {
                                    },
                                    label: const Text(
                                      '提现',
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontFamily: "oppoSansBold",
                                        // fontWeight: FontWeight.w900,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ))
                             /* Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                color: const Color.fromARGB(250, 255, 255, 255),
                                // elevation: 10,
                                // shadowColor: const Color.fromARGB(250, 231, 241, 251),
                                child: Container(
                                    margin: const EdgeInsets.all(10),
                                    child: TextButton.icon(
                                      icon:  Icon(Icons.money_outlined,size: 40,color: Colors.redAccent[400],),
                                      style: ElevatedButton.styleFrom(
                                          fixedSize: const Size(120, 60)),
                                      onPressed: () {
                                      },
                                      label: const Text(
                                        '提现',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: "oppoSansBold",
                                          // fontWeight: FontWeight.w900,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )),
                              ),*/
                            ],
                          ),
                          const SizedBox(height: 10,),
                        ],
                      ),
                    ),


          //交易记录
          const Divider(),
          Row(
            children: const [
              Padding(padding: EdgeInsets.all(10)),
              SizedBox(
                child: Text(
                  "交易记录:",
                  style:
                  TextStyle(
                      fontFamily: "oppoSansMedium",
                      // fontWeight: FontWeight.w900,
                      fontSize: 16),
                ),
              ),
              SizedBox(width: 90),
            ],
          ),
          const SizedBox(height: 10,),
          //各项记录信息(暂时是一个循环体)
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10,),

                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      color: const Color.fromARGB(250, 255, 255, 255),
                      elevation: 0,
                      borderOnForeground: false,
                      // shadowColor: const Color.fromARGB(250, 231, 241, 251),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(10),
                            child:  Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const[
                                ListTile(
                                  leading: Icon(Icons.money_off,color:  Color.fromARGB(250, 233, 46, 75),size: 40,),
                                  title:  Text("出发点：广州",style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "oppoSansRegular",
                                    // fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),),
                                  subtitle:  Text("终点站：上海",style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "oppoSansRegular",
                                    // fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),),
                                  trailing:  Text("消费50元",style: TextStyle(
                                    fontSize: 23,
                                    fontFamily: "oppoSansMedium",
                                    // fontWeight: FontWeight.w900,
                                    color: Colors.black,
                                  ),),
                                )
                              ],
                            ),
                          ),
                          const Divider(),
                          Container(
                              height: 70,
                              margin: const EdgeInsets.all(10),
                              child:
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:const [
                                  ListTile(
                                    leading: Icon(Icons.money, color: Color.fromARGB(250, 233, 46, 75),size: 40,),

                                    trailing:  Text("提现60元",style: TextStyle(
                                      fontSize: 23,
                                      fontFamily: "oppoSansMedium",
                                      /* fontSize: 16,
                                fontWeight: FontWeight.w900,*/
                                      color: Colors.black,
                                    ),),
                                  ),
                                ],
                              )

                          ),
                          const Divider(),
                          Container(
                              height: 70,
                              margin: const EdgeInsets.all(10),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:const [
                                  ListTile(
                                    leading: Icon(Icons.money, color: Color.fromARGB(250, 42, 173, 103),size: 40,),

                                    trailing:  Text("充值100元",style: TextStyle(
                                      fontSize: 23,
                                      fontFamily: "oppoSansMedium",
                                      /*fontSize: 16,
                            fontWeight: FontWeight.w900,*/
                                      color: Colors.black,
                                    ),),
                                  ),
                                ],
                              )
                          ),
                        ],
                      ),
                    ),
                    /*Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      color: const Color.fromARGB(250, 255, 255, 255),
                      // elevation: 10,
                      // shadowColor: const Color.fromARGB(250, 231, 241, 251),
                      child: ,
                    ),*/
              ],
            ),


        ],
      ),
    );
  }
}
