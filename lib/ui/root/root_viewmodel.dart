import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:my_app/ui/category/category_view.dart';
import 'package:my_app/ui/friend_category/friend_category_view.dart';
import 'package:my_app/ui/create_wish/create_wish_view.dart';
// import 'package:my_app/shared/waitingfor_screen.dart';

/// RootViewModel
class RootViewModel extends BaseViewModel {
  int _selectedIndex = 1;
  final List<Widget> _widgetOptions = <Widget>[
    FriendCategoryView(),
    CategoryView(),
    CreateWishView()
  ];

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

  /// TODO: imple this
  // buttom をTapしたとき動作
  // void onPlusButtomTapped() {
  //   print('ButtomTaped');
  //   _selectedIndex = _widgetOptions.length - 1;
  //   print(_selectedIndex);
  //   notifyListeners();
  // }

  final bottomNavigationBarItems = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Image.asset(
        "images/tabmenu/friend.png",
        width: 50,
        height: 50,
      ),
      label: 'Friend',
    ),
    BottomNavigationBarItem(
      icon: Image.asset(
        "images/tabmenu/cart.png",
        width: 50,
        height: 50,
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Image.asset(
        "images/tabmenu/pencil.png",
        width: 50,
        height: 50,
      ),
      label: 'Friend',
    )
  ];
}
