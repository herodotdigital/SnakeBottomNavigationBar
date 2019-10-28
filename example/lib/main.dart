import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SnakeNavigationBar Example ',
      theme: ThemeData(appBarTheme: AppBarTheme(color: Colors.deepPurpleAccent)),
      home: SnakeNavigationBarExampleScreen(),
    );
  }
}

class SnakeNavigationBarExampleScreen extends StatefulWidget {
  @override
  _SnakeNavigationBarExampleScreenState createState() => _SnakeNavigationBarExampleScreenState();
}

class _SnakeNavigationBarExampleScreenState extends State<SnakeNavigationBarExampleScreen> {
  int _selectedItemPosition = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SnakeNavigationBar Example')),
      bottomNavigationBar: SnakeNavigationBar(
        style: SnakeBarStyle.pinned,
        backgroundColor: Colors.deepPurpleAccent,
//        snakeShape: SnakeShape(
//            shape: BeveledRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(12), bottomLeft: Radius.circular(12))),
//            centered: true),
//        selectedIconColor: Colors.white,
//        selectionColor: Colors.red,
//        showUnselectedLabels: true,
//        showSelectedLabels: true,
//        elevation: 4,
//        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
//        padding: EdgeInsets.all(4),

        currentIndex: _selectedItemPosition,
        onTap: (index) => setState(() => _selectedItemPosition = index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.chat), title: Text('tickets')),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), title: Text('calendar')),
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('home')),
          BottomNavigationBarItem(icon: Icon(Icons.mic), title: Text('microphone')),
          BottomNavigationBarItem(icon: Icon(Icons.search), title: Text('search'))
        ],
      ),
    );
  }
}
