# flutter_snake_navigationbar_example

```
class SnakeBottomBarExampleScreen extends StatefulWidget {
  @override
  _SnakeBottomBarExampleScreenState createState() => _SnakeBottomBarExampleScreenState();
}

class _SnakeBottomBarExampleScreenState extends State<SnakeBottomBarExampleScreen> {
  int _selectedItemPosition = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SnakeBottomBar Example')),
      bottomNavigationBar: SnakeNavigationBar(
        style: SnakeBarStyle.pinned,
        backgroundColor: Colors.deepPurpleAccent,
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
```
