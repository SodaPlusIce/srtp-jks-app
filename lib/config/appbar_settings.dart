import 'package:flutter/material.dart';
class UnionAppBar extends AppBar{
 UnionAppBar({ required String title,Color colors =const Color.fromARGB(255, 244, 244, 244)})
  : super(
   bottom: PreferredSize(
       preferredSize: const Size.fromHeight(-15),
       child: Container(
     color:  Colors.red,
   )),
   title: Text(title,style: const TextStyle(
     fontFamily: "oppoSansBold",
     fontSize: 20,
     color: Colors.black
   ),
   ),
   backgroundColor: colors,
   elevation: 0,

   // centerTitle: true,

 );
}
