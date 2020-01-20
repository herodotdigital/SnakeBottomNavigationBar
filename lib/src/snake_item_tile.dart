import 'package:flutter/material.dart';
import 'selection_notifier.dart';

class SnakeItemTile extends StatelessWidget {
  final Widget icon;
  final Widget label;
  final bool selectedLabelVisible;
  final bool unselectedLabelVisible;
  final int position;
  final Color selectedColor;
  final Color unSelectedColor;
  final SelectionNotifier notifier;
  final SelectionStyle selectionStyle;

  SnakeItemTile(
    this.icon,
    this.label,
    this.selectedLabelVisible,
    this.unselectedLabelVisible,
    this.position,
    this.selectedColor,
    this.unSelectedColor,
    this.notifier,
    this.selectionStyle,
  );

  @override
  Widget build(BuildContext context) {
    final bool isSelected = notifier.currentIndex == position;

    return Expanded(
      child: GestureDetector(
        onTap: () => notifier.selectIndex(position),
        child: Container(
          color: Colors.transparent,
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: LayoutBuilder(
              builder: (context, constraint) {
                if (selectedLabelVisible && unselectedLabelVisible) {
                  return _getLabeledItem(isSelected);
                } else if (selectedLabelVisible) {
                  return isSelected
                      ? _getLabeledItem(isSelected)
                      : _getThemedIcon(isSelected);
                } else if (unselectedLabelVisible) {
                  return isSelected
                      ? _getThemedIcon(isSelected)
                      : _getLabeledItem(isSelected);
                } else {
                  return _getThemedIcon(isSelected);
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _getLabeledItem(isSelected) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _getThemedIcon(isSelected),
        SizedBox(height: 1),
        _getThemedTitle(isSelected),
      ],
    );
  }

  Widget _getThemedTitle(isSelected) {
    return DefaultTextStyle.merge(
      style: selectionStyle == SelectionStyle.color
          ? TextStyle(
              color: isSelected ? selectedColor : unSelectedColor,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)
          : TextStyle(
              color: unSelectedColor.withOpacity(isSelected ? 1 : 0.6),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
      child: label,
    );
  }

  Widget _getThemedIcon(isSelected) {
    return selectionStyle == SelectionStyle.color
        ? IconTheme(
            data: IconThemeData(
                color: isSelected ? selectedColor : unSelectedColor),
            child: icon,
          )
        : IconTheme(
            data: IconThemeData(
                color: unSelectedColor, opacity: isSelected ? 1 : 0.6),
            child: icon,
          );
  }
}

enum SelectionStyle {
  color,
  opacity,
}
