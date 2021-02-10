import 'package:flutter/material.dart';

/// SideMenu
class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: <Widget>[
        DrawerHeader(
          child: Text('My App'),
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        ),
        // sideMenuの要素
        ..._menuItems(context)
      ],
    ));
  }
}

/// sideMenu の要素　(Header 以外)
List<Widget> _menuItems(BuildContext context) {
  return [ListTile(title: Text('Tile1')), ListTile(title: Text('Tile2'))];
}
