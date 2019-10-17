import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SnakeBottomBar Example ',
      theme: ThemeData(appBarTheme: AppBarTheme(color: Colors.deepPurpleAccent)),
      home: SnakeBottomBarExampleScreen(),
    );
  }
}

class SnakeBottomBarExampleScreen extends StatefulWidget {
  @override
  _SnakeBottomBarExampleScreenState createState() => _SnakeBottomBarExampleScreenState();
}

class _SnakeBottomBarExampleScreenState extends State<SnakeBottomBarExampleScreen> {
  int _selectedItemPosition = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SnakeNavigationBar Example')),
      bottomNavigationBar: SnakeNavigationBar(
        style: SnakeBarStyle.pinned,
        type: SnakeType.indicator,
        backgroundColor: Colors.deepPurpleAccent,
//        selectedIconColor: Colors.white,
//        selectionColor: Colors.white,
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
