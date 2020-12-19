import 'package:flutter/foundation.dart';

class SelectionNotifier extends ChangeNotifier {
  int lastIndex;
  int currentIndex;
  final ValueChanged<int> onTap;

  SelectionNotifier(this.currentIndex, this.onTap);

  void selectIndex(int index) {
    lastIndex = currentIndex;
    currentIndex = index;
    onTap?.call(index);
    notifyListeners();
  }
}
