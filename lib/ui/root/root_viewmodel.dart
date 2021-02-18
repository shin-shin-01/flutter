import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:my_app/ui/home/home_view.dart';
import 'package:my_app/ui/category/category_view.dart';

/// RootViewModel
class RootViewModel extends BaseViewModel {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[MyHomePage(), CategoryView()];

  /// selectedIndex
  /// - 選択中のタブの index
  /// - 初期値: 0
  int get selectedIndex => _selectedIndex;

  /// selectWidget
  /// - 選択中のタブの widget (画面の内容)
  Widget get selectedWidget => _widgetOptions.elementAt(_selectedIndex);

  /// buttom をTapしたとき動作
  void onItemTapped(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  final bottomNavigationBarItems = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.school),
      label: 'Category',
    ),
  ];
}
