import 'package:flutter/material.dart';
import 'package:my_app/services_locator.dart';
import 'package:my_app/services/configuration.dart';

/// SideMenu
class SideMenu extends StatelessWidget {
  final _config = servicesLocator<ConfigurationService>();
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: <Widget>[
        DrawerHeader(
          child: Text('My App'),
          decoration: BoxDecoration(color: _config.appColor["sideMenuHeader"]),
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
