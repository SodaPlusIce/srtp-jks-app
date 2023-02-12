import 'package:flutter/material.dart';
import './pages/location.dart';
import './pages/map.dart';
import './pages/center.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = '智慧公交——定位';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    LocationPage(),
    MapPage(),
    CenterPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // leading: Icon(Icons.arrow_back_outlined),
      //   title: const Text('智能公交——预约响应'),
      // ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.room,size: 40,),
            label: '定位',
          ),
          BottomNavigationBarItem(
            icon: Icon(null),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,size: 40,),

            label: '个人中心',
          ),
        ],

        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
      floatingActionButton: Container(
        height: 90,
        width: 90,
        padding: const EdgeInsets.all(5),
        margin:const EdgeInsets.only(top: 40),
        decoration:   BoxDecoration(
            color: const Color.fromARGB(255, 250, 250, 250),
            borderRadius: BorderRadius.circular(40)

        ),
        child: FloatingActionButton(
          backgroundColor: _selectedIndex == 1?Colors.blue:Colors.grey,
          foregroundColor: Colors.white,
          child: const Icon(Icons.navigation,
            size: 40,
          ),
          onPressed: (){
            setState((){
              _selectedIndex = 1;
            });
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
