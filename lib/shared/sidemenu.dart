import 'package:flutter/material.dart';
import 'package:my_app/services_locator.dart';
import 'package:my_app/services/configuration.dart';
import 'package:my_app/services/navigation.dart';
import 'package:my_app/services/data.dart';

/// SideMenu
class SideMenu extends StatelessWidget {
  final _config = servicesLocator<ConfigurationService>();
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Drawer(
        child: ListView(
      children: <Widget>[
        Container(
          child: DrawerHeader(
            decoration:
                BoxDecoration(color: _config.appColor["sideMenuHeader"]),
          ),
          height: screenSize.height * 0.05,
        ),

        // sideMenuの要素
        ..._menuItems(context)
      ],
    ));
  }
}

/// sideMenu の要素　(Header 以外)
List<Widget> _menuItems(BuildContext context) {
  return [_accountIdTile(), _logoutTile(context), _settingTile(context)];
}

/// アカウントID
Widget _accountIdTile() {
  final _data = servicesLocator<DataService>();
  final user = _data.Me;

  return ListTile(
      title: Text(user.account_id),
      leading: Padding(
        child: CircleAvatar(
          backgroundImage: NetworkImage(user.picture_url),
          radius: 16,
        ),
        padding: EdgeInsets.all(8.0),
      ));
}

/// ログアウト
Widget _logoutTile(context) {
  return ListTile(
    title: Text('ログアウト'),
    leading: Padding(
      child: Image.asset("images/sidemenu/logout.png"),
      padding: EdgeInsets.all(8.0),
    ),
    onTap: () => logoutDialog(context),
  );
}

Future logoutDialog(context) {
  final _navigation = servicesLocator<NavigationService>();
  return showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        content: Text('ログアウトしますか？'),
        actions: <Widget>[
          FlatButton(
            child: Text("CANCEL"),
            onPressed: () {
              _navigation.pop();
            },
          ),
          FlatButton(
            child: Text("OK"),
            onPressed: () =>
                _navigation.pushNamedAndRemoveUntil(routeName: '/sign_in'),
          ),
        ],
      );
    },
  );
}

/// 設定
Widget _settingTile(context) {
  return ListTile(
    title: Text('設定'),
    leading: Padding(
      child: Image.asset("images/sidemenu/setting.png"),
      padding: EdgeInsets.all(8.0),
    ),
    // onTap: () => logoutDialog(context),
  );
}
