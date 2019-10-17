import 'package:flutter/foundation.dart';

class SelectionNotifier extends ChangeNotifier {
  int lastIndex;
  int currentIndex;
  final ValueChanged<int> onTap;

  SelectionNotifier(int defaultValue, this.onTap) : currentIndex = defaultValue;

  void selectIndex(int index) {
    lastIndex = currentIndex;
    currentIndex = index;
    onTap(index);
    notifyListeners();
  }
}
