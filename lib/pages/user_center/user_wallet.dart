import 'package:flutter/material.dart';
class UserWallPage extends StatefulWidget {
  const UserWallPage({Key? key}) : super(key: key);

  @override
  State<UserWallPage> createState() => _UserWallPageState();
}

class _UserWallPageState extends State<UserWallPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("钱包余额",style: TextStyle(
        fontWeight: FontWeight.w900,fontSize: 20,
      ),),),
      backgroundColor:  const Color.fromARGB(250, 239, 249, 255),
      body: ListView(
        children: [
          const SizedBox(height: 10,),
          //明细
          const Divider(),
          Row(
            children: const [
              Padding(padding: EdgeInsets.all(10)),
              SizedBox(
                child: Text(
                  "明细:",
                  style:
                  TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
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
                color: const Color.fromARGB(250, 250, 252, 254),
                // elevation: 10,
                // shadowColor: const Color.fromARGB(250, 231, 241, 251),
                child: Container(
                  height: 200,
                  width: 500,
                  margin: const EdgeInsets.all(10),
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        leading: Icon(Icons.monetization_on_outlined,color: Colors.greenAccent[400],size: 40,),
                        title: const Text("余额:",style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),),
                        trailing: const Text("2000元",style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),),
                      ),
                      const Divider(height: 50,),
                      ListTile(
                        leading: Icon(Icons.money_off,color: Colors.redAccent[400],size: 40,),
                        title: const Text("消费:",style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),),
                        trailing: const Text("5500元",style: TextStyle(
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
                  TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
                ),
              ),
              SizedBox(width: 90),

            ],
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                color: const Color.fromARGB(250, 250, 252, 254),
                elevation: 10,
                shadowColor: const Color.fromARGB(250, 231, 241, 251),
                child: Container(
                    margin: const EdgeInsets.all(10),
                    child: TextButton.icon(
                      icon:  Icon(Icons.money,size: 40,color: Colors.greenAccent[400],),
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(120, 60)),
                      onPressed: () {
                      },
                      label: const Text(
                        '充值',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                    )),
              ),
              const SizedBox(width: 40,),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                color: const Color.fromARGB(250, 250, 252, 254),
                elevation: 10,
                shadowColor: const Color.fromARGB(250, 231, 241, 251),
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
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                    )),
              ),
            ],
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
                  TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
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
                  color: const Color.fromARGB(250, 250, 252, 254),
                  // elevation: 10,
                  // shadowColor: const Color.fromARGB(250, 231, 241, 251),
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListTile(
                          leading: Icon(Icons.money_off,color: Colors.redAccent[400],size: 40,),
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
                          trailing: const Text("消费50元",style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  color: const Color.fromARGB(250, 250, 252, 254),
                  // elevation: 10,
                  // shadowColor: const Color.fromARGB(250, 231, 241, 251),
                  child: Container(
                    height: 70,
                    margin: const EdgeInsets.all(10),
                    child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ListTile(
                              leading: Icon(Icons.money, color: Colors.redAccent[400],size: 40,),

                              trailing: const Text("提现60元",style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                color: Colors.black,
                              ),),
                            ),
                          ],
                        )

                  ),
                ),
                const SizedBox(height: 10,),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  color: const Color.fromARGB(250, 250, 252, 254),
                  // elevation: 10,
                  // shadowColor: const Color.fromARGB(250, 231, 241, 251),
                  child: Container(
                    height: 70,
                    margin: const EdgeInsets.all(10),
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListTile(
                          leading: Icon(Icons.money, color: Colors.greenAccent[400],size: 40,),

                          trailing: const Text("充值100元",style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),),
                        ),
                      ],
                    )
                  ),
                ),
                const SizedBox(height: 10,),
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
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListTile(
                          leading: Icon(Icons.money_off,color: Colors.redAccent[400],size: 40,),
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
                          trailing: const Text("消费50元",style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  color: const Color.fromARGB(250, 250, 252, 254),
                  // elevation: 10,
                  // shadowColor: const Color.fromARGB(250, 231, 241, 251),
                  child: Container(
                      height: 70,
                      margin: const EdgeInsets.all(10),
                      child:
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListTile(
                            leading: Icon(Icons.money, color: Colors.redAccent[400],size: 40,),

                            trailing: const Text("提现60元",style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                            ),),
                          ),
                        ],
                      )

                  ),
                ),
                const SizedBox(height: 10,),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  color: const Color.fromARGB(250, 250, 252, 254),
                  // elevation: 10,
                  // shadowColor: const Color.fromARGB(250, 231, 241, 251),
                  child: Container(
                      height: 70,
                      margin: const EdgeInsets.all(10),
                      child:  Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListTile(
                            leading: Icon(Icons.money, color: Colors.greenAccent[400],size: 40,),

                            trailing: const Text("充值100元",style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                            ),),
                          ),
                        ],
                      )
                  ),
                ),
                const SizedBox(height: 10,),
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
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListTile(
                          leading: Icon(Icons.money_off,color: Colors.redAccent[400],size: 40,),
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
                          trailing: const Text("消费50元",style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  color: const Color.fromARGB(250, 250, 252, 254),
                  // elevation: 10,
                  // shadowColor: const Color.fromARGB(250, 231, 241, 251),
                  child: Container(
                      height: 70,
                      margin: const EdgeInsets.all(10),
                      child:
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListTile(
                            leading: Icon(Icons.money, color: Colors.redAccent[400],size: 40,),

                            trailing: const Text("提现60元",style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                            ),),
                          ),
                        ],
                      )

                  ),
                ),
                const SizedBox(height: 10,),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  color: const Color.fromARGB(250, 250, 252, 254),
                  // elevation: 10,
                  // shadowColor: const Color.fromARGB(250, 231, 241, 251),
                  child: Container(
                      height: 70,
                      margin: const EdgeInsets.all(10),
                      child:  Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListTile(
                            leading: Icon(Icons.money, color: Colors.greenAccent[400],size: 40,),

                            trailing: const Text("充值100元",style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                            ),),
                          ),
                        ],
                      )
                  ),
                ),
                const SizedBox(height: 10,),
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
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListTile(
                          leading: Icon(Icons.money_off,color: Colors.redAccent[400],size: 40,),
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
                          trailing: const Text("消费50元",style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  color: const Color.fromARGB(250, 250, 252, 254),
                  // elevation: 10,
                  // shadowColor: const Color.fromARGB(250, 231, 241, 251),
                  child: Container(
                      height: 70,
                      margin: const EdgeInsets.all(10),
                      child:
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListTile(
                            leading: Icon(Icons.money, color: Colors.redAccent[400],size: 40,),

                            trailing: const Text("提现60元",style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                            ),),
                          ),
                        ],
                      )

                  ),
                ),
                const SizedBox(height: 10,),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  color: const Color.fromARGB(250, 250, 252, 254),
                  // elevation: 10,
                  // shadowColor: const Color.fromARGB(250, 231, 241, 251),
                  child: Container(
                      height: 70,
                      margin: const EdgeInsets.all(10),
                      child:  Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListTile(
                            leading: Icon(Icons.money, color: Colors.greenAccent[400],size: 40,),

                            trailing: const Text("充值100元",style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                            ),),
                          ),
                        ],
                      )
                  ),
                ),
              ],
            ),


        ],
      ),
    );
  }
}
