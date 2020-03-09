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
        style: snakeBarStyle,
        snakeShape: snakeShape,
        snakeColor: selectionColor,
        backgroundColor: backgroundColor,
        showUnselectedLabels: showUnselectedLabels,
        showSelectedLabels: showSelectedLabels,
        shape: bottomBarShape,
        padding: padding,
        currentIndex: _selectedItemPosition,
        onPositionChanged: (index) =>
            setState(() => _selectedItemPosition = index),
        items: [
          BottomNavigationBarItem(
              icon: Icon(CustomIcons.tickets),
              title: Text('tickets', style: labelTextStyle)),
          BottomNavigationBarItem(
              icon: Icon(CustomIcons.calendar),
              title: Text('calendar', style: labelTextStyle)),
          BottomNavigationBarItem(
              icon: Icon(CustomIcons.home),
              title: Text('home', style: labelTextStyle)),
          BottomNavigationBarItem(
              icon: Icon(CustomIcons.podcasts),
              title: Text('microphone', style: labelTextStyle)),
          BottomNavigationBarItem(
              icon: Icon(CustomIcons.search),
              title: Text('search', style: labelTextStyle))
        ],
      ),
    );
  }
}
```
